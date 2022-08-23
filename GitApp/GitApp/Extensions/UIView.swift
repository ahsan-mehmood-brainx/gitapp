//
//  UIView.swift
//  GitApp
//
//  Created by BrainX 3096 on 23/08/2022.
//

import UIKit

extension UIView {
    enum ViewSide {
        case Left, Right, Top, Bottom
    }
    func addBorder(toSide side: ViewSide,
                   withColor color: UIColor,
                   andThickness thickness: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        switch side {
            case .Left: border.frame = CGRect(x: frame.minX, y: frame.minY, width: thickness, height: frame.height); break
            case .Right: border.frame = CGRect(x: frame.maxX, y: frame.minY, width: thickness, height: frame.height); break
            case .Top: border.frame = CGRect(x: frame.minX, y: frame.minY, width: frame.width, height: thickness); break
            case .Bottom: border.frame = CGRect(x: frame.minX, y: frame.maxY, width: frame.width, height: thickness); break
        }
        layer.addSublayer(border)
    }
}
