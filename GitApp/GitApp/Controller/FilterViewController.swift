//
//  FilterViewController.swift
//  GitApp
//
//  Created by BrainX 3096 on 22/08/2022.
//

import UIKit

class FilterViewController: BaseViewController {
    
    //MARK: Public Data Member
    var selectedLanguages: [String] = []
    
    //MARK: Closure
    var selectedLanguageCallBack: (([String])->Void)?
    
    //MARK: Outlet
    @IBOutlet var filterView: FilterView!
    
    //MARK: Action Methods
    @IBAction func clearButtonClicked() {
        selectedLanguages.removeAll()
        filterView.languagesTableView.reloadData()
    }
    
    @IBAction func applyButtonClicked() {
        selectedLanguageCallBack?(selectedLanguages)
        popViewController()
    }
    
    @objc
    private func imageTapped(sender: UITapGestureRecognizer) {
        if sender.state == .ended {
            popViewController()
        }
    }
    
    //MARK: Lifecycle Method
    override func viewDidLoad() {
        super.viewDidLoad()
        initialSetup()
    }
    
    //MARK: Private Methods
    private func initialSetup() {
        let cancelImageTapped = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        filterView.cancelImage.addGestureRecognizer(cancelImageTapped)
        filterView.cancelImage.isUserInteractionEnabled = true
        filterView.languagesTableView.dataSource = self
        filterView.languagesTableView.delegate = self
    }
    private func findIndex(_ stringArray: [String], _ givenString: String) -> Int? {
        for index in 0..<stringArray.count {
            if stringArray[index] == givenString {
                return index
            }
        }
        return nil
    }
}

//MARK: UITableViewDataSource Conformance
extension FilterViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LanguagesTableViewCell.reusableIdentifier) as! LanguagesTableViewCell
        if selectedLanguages.contains(Languages.language[indexPath.row]) {
            cell.isLanguageSelected.image = UIImage(named: CustomStrings.checkedImage)
        } else {
            cell.isLanguageSelected.image = UIImage(named: CustomStrings.unCheckedImage)
        }
        cell.languageLabelView.text = Languages.language[indexPath.row]
        return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        Languages.language.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if selectedLanguages.contains(Languages.language[indexPath.row]) {
            if let index = findIndex(selectedLanguages, Languages.language[indexPath.row]) {
                selectedLanguages.remove(at: index)
            }
        }
        else {
            selectedLanguages.append(Languages.language[indexPath.row])
        }
        filterView.languagesTableView.reloadData()
    }
}

//MARK: UITableViewDelegate Conformance
extension FilterViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let titleView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: tableView.frame.width, height: 40))
        let label = UILabel()
        label.frame = CGRect.init(x: 0, y: 0, width: titleView.frame.width, height: titleView.frame.height)
        label.text = CustomStrings.languagestableViewTitle
        label.font = Font.gilroySemiBold(16)
        titleView.addSubview(label)
        return titleView
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        50
    }
}

