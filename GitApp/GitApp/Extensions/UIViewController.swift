//
//  UIViewController.swift
//  GitApp
//
//  Created by BrainX 3096 on 26/08/2022.
//

import UIKit

extension UIViewController {
    
    static var reusableIdentifier: String {
        String(describing: self)
    }
    
    static func instantiate<ViewController: UIViewController>(_ viewControllerType: ViewController.Type,
                                                              fromStoryboard storyboardName: UIStoryboard.Name) -> ViewController {
        let storyboard = UIStoryboard(name: storyboardName.rawValue, bundle: nil)
        return storyboard.instantiateViewController(withIdentifier: viewControllerType.reusableIdentifier)as! ViewController
    }
}
