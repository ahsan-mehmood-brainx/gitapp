//
//  FilterView.swift
//  GitApp
//
//  Created by BrainX 3096 on 21/08/2022.
//

import UIKit

class FilterView: UIView {
    
    //MARK: Outlets
    @IBOutlet var cancelImage: UIImageView!
    @IBOutlet var filterLabel: UILabel!
    @IBOutlet var clearButton: UIButton!
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
        topView.addBottomBorderWithColor(color: Color.borderColor, width: 1)
        languagesTableView.separatorColor = .clear
        cancelImage.tintColor = Color.blackColor
        filterLabel.text = CustomStrings.filterLabel
        filterLabel.font = Font.gilroySemiBold(18)
        clearButton.setTitle(CustomStrings.clearText, for: .normal)
        clearButton.setTitleColor(Color.buttonTextColor, for: .normal)
        clearButton.backgroundColor = .clear
        clearButton.layer.cornerRadius = 12
        clearButton.layer.borderColor = Color.yellowColor.cgColor
        clearButton.layer.borderWidth = 1
        applyButton.setTitle(CustomStrings.applyText, for: .normal)
        applyButton.setTitleColor(Color.buttonTextColor, for: .normal)
        applyButton.backgroundColor = Color.yellowColor
        applyButton.layer.cornerRadius = 12
        languagesTableView.showsHorizontalScrollIndicator = false
        languagesTableView.showsVerticalScrollIndicator = false
    }
}
