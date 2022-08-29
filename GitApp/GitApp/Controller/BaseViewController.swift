//
//  BaseViewController.swift
//  GitApp
//
//  Created by BrainX 3096 on 23/08/2022.
//

import UIKit

class BaseViewController: UIViewController {
    
    //MARK: Public Methods
    func showAlert(_ error: APIError) {
        let alert = UIAlertController(title: CustomStrings.errorTitle,
                                      message: error.localizedDescription,
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
