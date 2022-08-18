//
//  GitTableViewCell.swift
//  GitApp
//
//  Created by BrainX 3096 on 17/08/2022.
//

import UIKit

class GitTableViewCell: UITableViewCell {
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
        let whiteColor = CGColor(red: 255, green: 255, blue: 255, alpha: 1)
        let grayColor = UIColor(rgb: 0xF8F8F8)
        let borderColor = UIColor(red: 00, green: 227, blue: 230, alpha: 1)
        mainView.clipsToBounds = true
        mainView.layer.cornerRadius = 15
        mainView.layer.borderWidth = 1
        backImageView.layer.borderWidth = 1
        backImageView.layer.borderColor = borderColor.cgColor
        mainView.layer.borderColor = borderColor.cgColor
        avatorView.layer.cornerRadius = 8
        avatorImageView.layer.borderWidth = 2
        avatorImageView.layer.cornerRadius = 8
        countView.layer.cornerRadius = 6
        countView.backgroundColor = grayColor
        contributionView.backgroundColor = grayColor
        avatorImageView.layer.borderColor = whiteColor
        languageLabelView.layer.cornerRadius = 6
        contributionView.layer.cornerRadius = 6
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
