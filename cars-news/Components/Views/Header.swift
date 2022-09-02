//
//  Header.swift
//  cars-news
//
//  Created by iOS Developer on 9/2/22.
//

import Foundation
import UIKit

final class Header: UIView {
    private var headerText: String = ""
    
    private let title: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .white
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byTruncatingTail
        
        return label
    }()
    
    func initialize(text: String) {
        self.title.text = text
        
        self.styleSetup()
    }
    
    private func styleSetup() {
        self.addSubview(self.title)
        
        self.title.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        
        self.title.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 12).isActive = true
        self.title.topAnchor.constraint(equalTo: self.topAnchor, constant: 12).isActive = true
        
        self.backgroundColor = Colors.headerBackground.color
    }
}
