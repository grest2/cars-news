//
//  NewsView.swift
//  cars-news
//
//  Created by iOS Developer on 9/2/22.
//

import Foundation
import UIKit

class NewsView: UIView {
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 12
        imageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        return imageView
    }()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        return scrollView
    }()
    
    private let newsTextStack: UIStackView = {
        let stack = UIStackView()
        stack.distribution = .fillEqually
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        return stack
    }()
    
    private let newsTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let newsText: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = Colors.secondary.color
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let header: Header = Header()
    
    public func initialize(image: UIImage?, title: String, body: String) {
        self.imageView.image = image
        self.newsTitle.text = title
        self.newsText.text = body
        
        self.setupStyle()
    }
    
    private func setupStyle() {
//        self.addSubview(header)
//
//        header.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
//        header.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
//        header.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
//        header.heightAnchor.constraint(equalToConstant: 60).isActive = true
//
        self.addSubview(self.scrollView)
        
//        scrollView.topAnchor.constraint(equalTo: header.bottomAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        scrollView.addSubview(self.newsTextStack)
        
        self.newsTextStack.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor).isActive = true
        self.newsTextStack.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor).isActive = true
        self.newsTextStack.topAnchor.constraint(equalTo: self.scrollView.topAnchor).isActive = true
        self.newsTextStack.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor).isActive = true
        
        self.newsTextStack.addArrangedSubview(self.newsTitle)
        self.newsTextStack.addArrangedSubview(self.newsText)
    }
}
