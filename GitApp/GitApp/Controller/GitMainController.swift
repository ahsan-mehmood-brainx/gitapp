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
    private var searchText: String = ""
    
    //MARK: Public Property
    let viewModel = GitMainViewModel()
    
    //MARK: Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        initialSetup()
        }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if viewModel.selectedLanguages.isEmpty {
            disableIconBadge()
        }
        else {
            showIconBadge()
        }
    }
    
    //MARK: Action Method
    @objc
    private func imageTapped(sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            let filterViewController = UIViewController.instantiate(FilterViewController.self, fromStoryboard: .Main)
            filterViewController.filterViewModel.selectedLanguages = viewModel.selectedLanguages
            filterViewController.filterViewModel.selectedLanguageCallBack =  { result in
                self.viewModel.selectedLanguages = result
                self.viewModel.filterRepositories(with: self.searchText)
                self.gitMainScreen.gitListView.reloadData()
            }
            navigationController?.pushViewController(filterViewController, animated: true)
            hideNavigationBar()
        }
    }
    
    //MARK: Private Methods
    private func fetchData() {
        viewModel.fetchData{ response in
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
        gitMainScreen.iconBadgeLabel.text = String(viewModel.selectedLanguages.count)
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
       
        cell.setCellData(viewModel.filteredRepositories[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.filteredRepositories.count
    }
}

//MARK: UISearchBarDelegate Conformance
extension GitMainController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        isSearchBarContainsText = searchText.count > 0
        self.searchText = searchText
        viewModel.filterRepositories(with: self.searchText)
        gitMainScreen.gitListView.reloadData()
    }
}
