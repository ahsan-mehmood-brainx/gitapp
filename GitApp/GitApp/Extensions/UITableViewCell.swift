//
//  UITableViewCell.swift
//  GitApp
//
//  Created by BrainX 3096 on 26/08/2022.
//

import UIKit

extension UITableViewCell {
    
    static var reusableIdentifier: String {
        String(describing: self)
    }
    
    func setZeroInsets() {
        preservesSuperviewLayoutMargins = false
        separatorInset = UIEdgeInsets.zero
        layoutMargins = UIEdgeInsets.zero
    }
}
