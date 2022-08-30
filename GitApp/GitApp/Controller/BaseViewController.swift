//
//  BaseViewController.swift
//  GitApp
//
//  Created by BrainX 3096 on 23/08/2022.
//

import UIKit

class BaseViewController: UIViewController {
    
    //MARK: Public Methods
    func showAlert(withMessage error: String) {
        let alert = UIAlertController(title: CustomStrings.errorTitle,
                                      message: error,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: CustomStrings.dismiss, style: .cancel, handler: nil))
        present(alert,animated: true)
    }
    func hideNavigationBar() {
        navigationController?.navigationBar.isHidden = true
    }
    func popViewController() {
        navigationController?.popViewController(animated: true)
    }
}
