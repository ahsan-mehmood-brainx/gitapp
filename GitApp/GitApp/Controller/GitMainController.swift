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
    @IBOutlet var gitMainScreen: GitListView!
    
    //MARK: Private Members
    private let repoListRequest = RepoListApiManager()
    private var gitRepositories = [GitRepository]()
    
    //MARK: Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        gitMainScreen.gitListView.dataSource = self
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let searchBarStyle = gitMainScreen.searchBar.value(forKey: "searchField") as? UITextField
        searchBarStyle?.clearButtonMode = .never
        gitMainScreen.searchBar.searchTextField.font = Font.gilroyMedium(14)
        searchBarStyle?.textColor = Color.searchBarTextColor
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
}

    //MARK: UITableViewDataSource Methods
extension GitMainController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GitTableViewCell", for: indexPath) as! GitTableViewCell
        cell.setCellData(gitRepositories[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gitRepositories.count
    }
}



