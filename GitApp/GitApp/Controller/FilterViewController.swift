//
//  FilterViewController.swift
//  GitApp
//
//  Created by BrainX 3096 on 22/08/2022.
//

import UIKit

class FilterViewController: UIViewController {
    //MARK: Outlet
    @IBOutlet var filterView: FilterView!
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        initialSetup()
    }
    private func initialSetup() {
        filterView.filterLabel.text = CustomStrings.filterLabel
        filterView.filterLabel.font = Font.gilroySemiBold(18)
        filterView.crossButton.setTitle("x", for: .normal)
        filterView.cancelButton.setTitle(CustomStrings.clearText, for: .normal)
        filterView.cancelButton.setTitleColor(Color.buttonTextColor, for: .normal)
        filterView.cancelButton.backgroundColor = .clear
        filterView.cancelButton.layer.cornerRadius = 12
        filterView.cancelButton.layer.borderWidth = 1
        filterView.layer.borderColor = Color.yellowColor.cgColor
        
        filterView.applyButton.setTitle(CustomStrings.applyText, for: .normal)
        filterView.applyButton.setTitleColor(Color.buttonTextColor, for: .normal)
        filterView.applyButton.backgroundColor = Color.yellowColor
        filterView.applyButton.layer.cornerRadius = 12
        filterView.applyButton.titleLabel?.font = Font.gilroySemiBold(40)
    }
}
