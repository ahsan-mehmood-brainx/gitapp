//
//  LanguagesTableViewCell.swift
//  GitApp
//
//  Created by BrainX 3096 on 23/08/2022.
//

import UIKit

class LanguagesTableViewCell: UITableViewCell {
    
    //MARK: Outlets
    @IBOutlet var isLanguageSelected: UIImageView!
    @IBOutlet var languageLabelView: UILabel!
    
    //MARK: Lifecycle Methods
    override func awakeFromNib() {
        super.awakeFromNib()
        languageLabelView.font = Font.gilroyMedium(15)
        isLanguageSelected.image = UIImage(named: CustomStrings.unCheckedImage)
    }
}
