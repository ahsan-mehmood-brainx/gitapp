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
    
    //MARK: Outlet
    @IBOutlet var gitMainScreen: GitTableView!
    
    //MARK: Private Property
    private var isSearchBarContainsText: Bool = false
    
    //MARK: Public Property
    let gitMainViewModel = GitMainViewModel()
    
    //MARK: Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        initialSetup()
        }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if !gitMainViewModel.selectedLanguages.isEmpty {
            gitMainViewModel.languagesRepositories =  gitMainViewModel.repositoryFilteringbyLanguage(gitMainViewModel.gitRepositories, gitMainViewModel.selectedLanguages)
            gitMainScreen.gitListView.reloadData()
            showIconBadge()
        }
        else {
            disableIconBadge()
        }
    }
    
    //MARK: Action Method
    @objc
    private func imageTapped(sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            let filterViewController = UIViewController.instantiate(FilterViewController.self, fromStoryboard: .Main)
            filterViewController.filterViewModel.selectedLanguages = gitMainViewModel.selectedLanguages
            filterViewController.filterViewModel.selectedLanguageCallBack =  { result in
                self.gitMainViewModel.selectedLanguages = result
            }
            navigationController?.pushViewController(filterViewController, animated: true)
            hideNavigationBar()
        }
    }
    
    //MARK: Private Methods
    private func fetchData() {
        gitMainViewModel.fetchData{ response in
            guard let message = response else {
                self.gitMainScreen.gitListView.reloadData()
                return 
            }
            self.showAlert(withMessage: message)
        }
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
    private func showIconBadge() {
        gitMainScreen.iconBadgeLabel.isHidden = false
        gitMainScreen.iconBadgeLabel.text = String(gitMainViewModel.selectedLanguages.count)
        gitMainScreen.iconBadgeLabel.layer.masksToBounds = true
        gitMainScreen.iconBadgeLabel.backgroundColor = Color.darkOrange
        gitMainScreen.iconBadgeLabel.layer.cornerRadius = 10
        gitMainScreen.iconBadgeLabel.textColor = Color.whiteColor
    }
    private func disableIconBadge() {
        gitMainScreen.iconBadgeLabel.isHidden = true
    }
}

//MARK: UITableViewDataSource Methods
extension GitMainController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GitTableViewCell", for: indexPath) as! GitTableViewCell
        if isSearchBarContainsText, gitMainViewModel.selectedLanguages.isEmpty {
            cell.setCellData(gitMainViewModel.searchRepositories[indexPath.row])
        } else if isSearchBarContainsText, !gitMainViewModel.selectedLanguages.isEmpty {
            cell.setCellData(gitMainViewModel.searchAndLanguageRepositories[indexPath.row])
        } else if !isSearchBarContainsText, gitMainViewModel.selectedLanguages.isEmpty {
            cell.setCellData(gitMainViewModel.gitRepositories[indexPath.row])
        } else {
            cell.setCellData(gitMainViewModel.languagesRepositories[indexPath.row])
        }
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearchBarContainsText, gitMainViewModel.selectedLanguages.isEmpty {
            return gitMainViewModel.searchRepositories.count
        } else if isSearchBarContainsText, !gitMainViewModel.selectedLanguages.isEmpty {
            return gitMainViewModel.searchAndLanguageRepositories.count
        } else if !isSearchBarContainsText, gitMainViewModel.selectedLanguages.isEmpty {
            return gitMainViewModel.gitRepositories.count
        } else {
            return gitMainViewModel.languagesRepositories.count
        }
    }
}

//MARK: UISearchBarDelegate Conformance
extension GitMainController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        isSearchBarContainsText = searchText.count > 0
        if gitMainViewModel.selectedLanguages.isEmpty {
            gitMainViewModel.searchRepositories.removeAll()
            gitMainViewModel.searchRepositories = gitMainViewModel.gitRepositories.filter{$0.name?.lowercased().contains(searchText.lowercased()) ?? false}
        } else {
            gitMainViewModel.searchAndLanguageRepositories.removeAll()
            gitMainViewModel.searchAndLanguageRepositories = gitMainViewModel.languagesRepositories.filter{$0.name?.lowercased().contains(searchText.lowercased()) ?? false }
        }
        gitMainScreen.gitListView.reloadData()
    }
}
