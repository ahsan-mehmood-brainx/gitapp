//
//  GitTableView.swift
//  GitApp
//
//  Created by BrainX 3096 on 23/08/2022.
//

import UIKit
class GitTableView: UIView {
    
    //MARK: Outlets
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet var iconImage: UIImageView!
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
