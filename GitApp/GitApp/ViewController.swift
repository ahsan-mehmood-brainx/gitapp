//
//  ViewController.swift
//  GitApp
//
//  Created by BrainX 3096 on 16/08/2022.
//

import UIKit

class GitMainController: UIViewController {
    //MARK: Outlets
    @IBOutlet var gitMainScreen: GitListView!
    //MARK: Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
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
    //MARK: Conformance to UITableViewDataSource Protocol
extension GitMainController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "GitTableViewCell", for: indexPath) as! GitTableViewCell
        cell.languageLabel.text = "English"
        cell.ownerNameLabel.text = "Ahsan"
        cell.descriptionLabel.text = "description"
        cell.countLabel.text = String(26) + " count"
        cell.contributionLabel.text = String(100) + " contribution"
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
}

