//
//  BaseViewController.swift
//  GitApp
//
//  Created by BrainX 3096 on 23/08/2022.
//

import Foundation
import UIKit

class BaseViewController: UIViewController {
    func showAlert(_ error: APIError) {
        let alert = UIAlertController(title:CustomStrings.errorTitle, message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: CustomStrings.dismiss, style: .cancel, handler: { action in}))
        present(alert,animated: true)
    }
}
