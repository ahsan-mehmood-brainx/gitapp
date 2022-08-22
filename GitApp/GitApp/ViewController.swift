//
//  ViewController.swift
//  GitApp
//
//  Created by BrainX 3096 on 21/08/2022.
//


import UIKit

class GitMainController: UIViewController {
    //MARK: Outlets
    @IBOutlet var gitMainScreen: GitListView!
    //MARK: Private variable having gitapiresponse
    var gitResponse = [GitApiResponse]()
    var gitOwner: GithubOwner?
    //MARK: Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
        loadData()
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
    //MARK: Conformance to UITableViewDataSource Protocol
extension GitMainController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GitTableViewCell", for: indexPath) as! GitTableViewCell
        let id: Int = gitResponse[indexPath.row].gitOwner?.gitOwnerId ?? 0
        let avatorImageString: String =  gitResponse[indexPath.row].gitOwner?.avatorUrl ?? "N/A"
        let avatorImageUrl = URL(string: avatorImageString)
        cell.avatorImageView.load(url: avatorImageUrl!)
        cell.languageLabel.text = "English"
        cell.ownerNameLabel.text = gitResponse[indexPath.row].name ?? "N/A"
        cell.descriptionLabel.text = gitResponse[indexPath.row].fullName ?? "N/A"
        cell.countLabel.text = String(gitResponse[indexPath.row].id!) + " count"
        cell.contributionLabel.text = String(id) + " contributions"
        print("ABCDEF")
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gitResponse.count
    }
}



