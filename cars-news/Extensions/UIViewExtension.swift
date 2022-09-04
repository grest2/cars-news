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
    
    func tappingAnimation(_ completion: @escaping () -> Void) {
        self.isUserInteractionEnabled = false
        
        UIView.animate(withDuration: 0.1, delay: 0, options: .curveLinear, animations: {
            [weak self] in
            
            self?.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        }) {
            _ in
            completion()
        }
    }
}
