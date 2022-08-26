//
//  GitMainController.swift
//  GitApp
//
//  Created by BrainX 3096 on 22/08/2022.
//

import Alamofire
import ObjectMapper
import UIKit

class GitMainController: BaseViewController {
    
    //MARK: Outlets
    @IBOutlet var gitMainScreen: GitTableView!
    
    //MARK: Private Members
    private let repoListRequest = RepoListApiManager()
    private var isSearchBarContainsText: Bool = false
    private var selectedLanguages: [String] = []
    private var gitRepositories = [GitRepository]()
    private var searchRepositories: [GitRepository] = []
    private var languagesRepositories: [GitRepository]!
    private var searchAndLanguageRepositories = [GitRepository]()
    
    //MARK: Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        initialSetup()
        }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if !selectedLanguages.isEmpty {
            languagesRepositories = repositoryFilteringbyLanguage(gitRepositories, selectedLanguages)
            gitMainScreen.gitListView.reloadData()
        }
        if !selectedLanguages.isEmpty {
            gitMainScreen.iconBadgeLabel.text = String(selectedLanguages.count)
            gitMainScreen.iconBadgeLabel.layer.masksToBounds = true
            gitMainScreen.iconBadgeLabel.backgroundColor = Color.darkOrange
            gitMainScreen.iconBadgeLabel.layer.cornerRadius = 10
            gitMainScreen.iconBadgeLabel.textColor = Color.whiteColor
        }
    }
    
    //MARK: Action Method
    @objc
    private func imageTapped(sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            let filterViewController = UIViewController.instantiate(FilterViewController.self, fromStoryboard: .Main)
            filterViewController.selectedLanguages = selectedLanguages
            filterViewController.selectedLanguageCallBack =  { result in
                self.selectedLanguages = result
            }
            navigationController?.pushViewController(filterViewController, animated: true)
            hideNavigationBar()
        }
    }
    
    //MARK: Private Methods
    private func fetchData() {
        repoListRequest.loadRepositories {response in
            switch response {
            case let .success(value):
                self.gitRepositories = value
                self.gitMainScreen.gitListView.reloadData()
            case let .failure(error):
                self.showAlert(error)
            }
        }
    }
    private func repositoryFilteringbyLanguage(_ gitRepositoryArray: [GitRepository],
                                               _ languagesArray: [String])-> [GitRepository] {
        var repoFilter: [GitRepository] = []
        var index = 0
        for repo in gitRepositoryArray {
            if languagesArray.contains(repo.language ?? "") {
                repoFilter.insert(repo, at: index)
                index += 1
            }
        }
        return repoFilter
    }
    private func initialSetup() {
        gitMainScreen.gitListView.dataSource = self
        gitMainScreen.searchBar.delegate = self
        let iconImageTapped = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        gitMainScreen.iconImage.addGestureRecognizer(iconImageTapped)
        gitMainScreen.iconImage.isUserInteractionEnabled = true
        let searchBarStyle = gitMainScreen.searchBar.value(forKey: "searchField") as? UITextField
        searchBarStyle?.clearButtonMode = .never
        gitMainScreen.searchBar.searchTextField.font = Font.gilroyMedium(14)
        searchBarStyle?.textColor = Color.searchBarTextColor
    }
}

//MARK: UITableViewDataSource Methods
extension GitMainController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GitTableViewCell", for: indexPath) as! GitTableViewCell
        if isSearchBarContainsText, selectedLanguages.isEmpty {
            cell.setCellData(searchRepositories[indexPath.row])
        } else if isSearchBarContainsText, !selectedLanguages.isEmpty {
            cell.setCellData(searchAndLanguageRepositories[indexPath.row])
        } else if !isSearchBarContainsText, selectedLanguages.isEmpty {
            cell.setCellData(gitRepositories[indexPath.row])
        } else {
            cell.setCellData(languagesRepositories[indexPath.row])
        }
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearchBarContainsText, selectedLanguages.isEmpty {
            return searchRepositories.count
        } else if isSearchBarContainsText, !selectedLanguages.isEmpty {
            return searchAndLanguageRepositories.count
        } else if !isSearchBarContainsText, selectedLanguages.isEmpty {
            return gitRepositories.count
        } else {
            return languagesRepositories.count
        }
    }
}

//MARK: UISearchBarDelegate Conformance
extension GitMainController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count > 0 {
            isSearchBarContainsText = true
        } else {
            isSearchBarContainsText = false
        }
        searchRepositories.removeAll()
        if selectedLanguages.isEmpty {
            var index = 0
            for gitRepo in gitRepositories {
                let gitName = gitRepo.name ?? ""
                if gitName.lowercased().contains(searchText.lowercased()) {
                    searchRepositories.insert(gitRepo, at: index)
                    index += 1
                }
            }
        } else {
            searchAndLanguageRepositories.removeAll()
            var index = 0
            for gitRepo in languagesRepositories {
                let gitName = gitRepo.name ?? ""
                if gitName.lowercased().contains(searchText.lowercased()) {
                    searchAndLanguageRepositories.insert(gitRepo, at: index)
                    index += 1
                }
            }
        }
        gitMainScreen.gitListView.reloadData()
    }
}
