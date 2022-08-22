//
//  GitTableViewCell.swift
//  GitApp
//
//  Created by BrainX 3096 on 17/08/2022.
//

import UIKit

class GitTableViewCell: UITableViewCell {
    //MARK: Outlets
    @IBOutlet var backImageView: UIImageView!
    @IBOutlet var languageLabel: UILabel!
    @IBOutlet var avatorImageView: UIImageView!
    @IBOutlet var ownerNameLabel: UILabel!
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var countLabel: UILabel!
    @IBOutlet var contributionLabel: UILabel!    
    @IBOutlet var mainView: UIView!
    @IBOutlet var languageLabelView: UIView!
    @IBOutlet var avatorView: UIView!
    @IBOutlet var countView: UIView!
    @IBOutlet var contributionView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cellStyling()
    }
    
    //MARK: CellCustomStyling
    private func cellStyling() {
        mainView.clipsToBounds = true
        languageLabel.font = Font.gilroyMedium(12)
        ownerNameLabel.font = Font.gilroyMedium(16)
        descriptionLabel.font = Font.gilroyMedium(12)
        countLabel.font = Font.gilroyMedium(12)
        contributionLabel.font = Font.gilroyMedium(12)
        mainView.layer.cornerRadius = 15
        mainView.layer.borderWidth = 1
        backImageView.layer.borderWidth = 1
        backImageView.layer.borderColor = Color.borderColor.cgColor
        mainView.layer.borderColor = Color.borderColor.cgColor
        avatorView.layer.cornerRadius = 8
        avatorImageView.layer.borderWidth = 2
        avatorImageView.layer.cornerRadius = 8
        countView.layer.cornerRadius = 6
        countView.backgroundColor = Color.grayColor
        contributionView.backgroundColor = Color.grayColor
        avatorImageView.layer.borderColor = Color.whiteColor.cgColor
        languageLabelView.layer.cornerRadius = 6
        contributionView.layer.cornerRadius = 6
    }
}
