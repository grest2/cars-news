//
//  ErrorCard.swift
//  cars-news
//
//  Created by iOS Developer on 9/11/22.
//

import Foundation
import UIKit

final class ErrorCard: UIView {
    private let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 18)
        
        return label
    }()
    
    func show(error: String?) {
        self.label.text = error
        self.isHidden = false
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.label.text = nil
            self.isHidden = true
        }
    }
    
    func initialize() {
        self.setupStyle()
    }
    
    private func setupStyle() {
        self.addSubview(self.label)
        
        label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12).isActive = true
        label.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -12).isActive = true
        label.topAnchor.constraint(equalTo: self.topAnchor, constant: 12).isActive = true
        label.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -12).isActive = true
        
        
        self.layer.cornerRadius = 8
        self.backgroundColor = Colors.headerBackground.color
    }
}
