//
//  ImageView.swift
//  GitApp
//
//  Created by BrainX 3096 on 19/08/2022.
//

import UIKit
extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            guard let data = try? Data(contentsOf: url),
                  let image = UIImage(data: data) else {
                      return
                  }
            DispatchQueue.main.async {
                self?.image = image
            }
        }
    }
}
