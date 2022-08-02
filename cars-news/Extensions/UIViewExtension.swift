//
//  UIViewExtension.swift
//  cars-news
//
//  Created by iOS Developer on 8/2/22.
//

import UIKit

extension UIView {
    func setBorder(color: UIColor, width: CGFloat = 1) {
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = width
    }
}
