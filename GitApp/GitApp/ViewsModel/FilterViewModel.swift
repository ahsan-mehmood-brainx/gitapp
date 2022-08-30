//
//  FilterViewModel.swift
//  GitApp
//
//  Created by BrainX 3096 on 30/08/2022.
//

import UIKit

class FilterViewModel {
    
    //MARK: Public Data Member
    var selectedLanguages: [String] = []
    var languagesCount = Languages.language.count
    
    //MARK: Closure
    var selectedLanguageCallBack: (([String])->Void)?
    
    //MARK: Public Methods
    func findIndex(_ stringArray: [String], _ givenString: String) -> Int? {
        stringArray.firstIndex(where: {$0 == givenString})
    }
    func cellSelect(cellIndex: Int) {
        if selectedLanguages.contains(Languages.language[cellIndex]) {
            if let index = findIndex(selectedLanguages, Languages.language[cellIndex]) {
                selectedLanguages.remove(at: index)
            }
        }
        else {
            selectedLanguages.append(Languages.language[cellIndex])
        }
    }
    func removeAllSelectedLanguages() {
        selectedLanguages.removeAll()
    }
    func languageAtGivenIndex(_ index: Int)-> String {
        Languages.language[index]
    }
}
