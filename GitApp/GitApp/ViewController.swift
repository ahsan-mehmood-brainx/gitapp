//
//  ViewController.swift
//  GitApp
//
//  Created by BrainX 3096 on 16/08/2022.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var gitTableView:UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
    private func initialSetup() {
        self.gitTableView.dataSource = self
        self.searchBar.searchBarStyle = .minimal
        gitTableView.allowsSelection = false
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let searchBarStyle = searchBar.value(forKey: "searchField") as? UITextField
        searchBarStyle?.clearButtonMode = .never
        searchBar.searchTextField.font = UIFont(name: "Gilroy-Medium", size: 14.0)
        searchBarStyle?.textColor = UIColor(rgb: 0x818181)
        //searchBarStyle?.text.
    }
}
extension ViewController: UITableViewDataSource {
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
        print("ABC")
        return 10
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
}

