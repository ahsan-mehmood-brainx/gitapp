//
//  GitMainController.swift
//  GitApp
//
//  Created by BrainX 3096 on 22/08/2022.
//

import UIKit
import Alamofire
import ObjectMapper

class GitMainController: UIViewController {
    //MARK: Outlets
    @IBOutlet var gitMainScreen: GitListView!
    //MARK: Private variable having gitapiresponse
    let repoListRequest = RepoListApiManager()
    var gitRepositories = [GitRepository]()
    //MARK: Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        repoListRequest.loadRepositories {response in
            switch response {
            case let .success(value):
                self.gitRepositories = value
                self.gitMainScreen.gitListView.reloadData()
            case .failure:
                break
            }
        }
        initialSetup()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let searchBarStyle = gitMainScreen.searchBar.value(forKey: "searchField") as? UITextField
        searchBarStyle?.clearButtonMode = .never
        gitMainScreen.searchBar.searchTextField.font = Font.gilroyMedium(14)
        searchBarStyle?.textColor = Color.searchBarTextColor
    }
    //MARK: InitialSetup
    private func initialSetup() {
        gitMainScreen.gitListView.dataSource = self
        gitMainScreen.searchBar.searchBarStyle = .minimal
        gitMainScreen.gitListView.separatorColor = .clear
        gitMainScreen.gitListView.allowsSelection = false
    }
}

    //MARK: Conformance to Protocol
extension GitMainController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GitTableViewCell", for: indexPath) as! GitTableViewCell
        let id: Int = gitRepositories[indexPath.row].gitOwner?.gitOwnerId ?? 0
        let avatorImageString: String =  gitRepositories[indexPath.row].gitOwner?.avatorUrl ?? CustomStrings.repoLanguage
        let avatorImageUrl = URL(string: avatorImageString)
        cell.avatorImageView.load(url: avatorImageUrl!)
        cell.languageLabel.text = CustomStrings.repoLanguage
        cell.ownerNameLabel.text = gitRepositories[indexPath.row].name ?? CustomStrings.notAvailable
        cell.descriptionLabel.text = gitRepositories[indexPath.row].fullName ?? CustomStrings.notAvailable
        cell.countLabel.text = String(gitRepositories[indexPath.row].id!) + CustomStrings.count
        cell.contributionLabel.text = String(id) + CustomStrings.contribution
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gitRepositories.count
    }
}



