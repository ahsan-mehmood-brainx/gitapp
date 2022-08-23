//
//  GitListView.swift
//  GitApp
//
//  Created by BrainX 3096 on 18/08/2022.
//

import UIKit

class GitListView: UIView {
    
    //MARK: Outlets
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var gitListView: UITableView!
    override func awakeFromNib() {
        super.awakeFromNib()
        initialSetup()
    }
    
    //MARK: Private Method
    private func initialSetup() {
        searchBar.searchBarStyle = .minimal
        gitListView.separatorColor = .clear
        gitListView.allowsSelection = false
    }
}
