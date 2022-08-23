//
//  FilterView.swift
//  GitApp
//
//  Created by BrainX 3096 on 21/08/2022.
//

import UIKit

class FilterView: UIView {
    
    //MARK: Outlets
    @IBOutlet var crossButton: UIButton!
    @IBOutlet var filterLabel: UILabel!
    @IBOutlet var cancelButton: UIButton!
    @IBOutlet var applyButton: UIButton!
    @IBOutlet var languagesTableView: UITableView!
    @IBOutlet var topView: UIView!
    
    //MARK: Lifecycle Method
    override func awakeFromNib() {
        super.awakeFromNib()
        initialSetup()
    }
    
    //MARK: Private Method
    private func initialSetup() {
        filterLabel.text = CustomStrings.filterLabel
        filterLabel.font = Font.gilroySemiBold(18)
        crossButton.setTitle("X", for: .normal)
        crossButton.setTitleColor(Color.buttonTextColor, for: .normal)
        cancelButton.setTitle(CustomStrings.clearText, for: .normal)
        cancelButton.setTitleColor(Color.buttonTextColor, for: .normal)
        cancelButton.backgroundColor = .clear
        cancelButton.layer.cornerRadius = 12
        cancelButton.layer.borderWidth = 1
        applyButton.setTitle(CustomStrings.applyText, for: .normal)
        applyButton.setTitleColor(Color.buttonTextColor, for: .normal)
        applyButton.backgroundColor = Color.yellowColor
        applyButton.layer.cornerRadius = 12
        applyButton.titleLabel?.font = Font.gilroySemiBold(40)
    }
}
