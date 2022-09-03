//
//  NewsView.swift
//  cars-news
//
//  Created by iOS Developer on 9/2/22.
//

import Foundation
import UIKit

final class NewsView: UIView {
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 12
        imageView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        
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
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.textColor = UIColor.white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        
        return label
    }()
    
    private let newsText: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = Colors.secondary.color
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        
        return label
    }()
    
    private let newsSrc: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = Colors.secondary.color
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = "Подробнее..."
        
        return label
    }()
    
    private let categoryType: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = Colors.secondary.color
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        
        return label
    }()
    
    private let publishedDateNews: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = Colors.secondary.color
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        
        return label
    }()
    
    private let header: Header = Header()
    
    public func initialize(image: UIImage?, title: String, body: String, date: String, fullUrl: String, category: String) {
        self.imageView.image = image
        self.newsTitle.text = title
        self.newsText.text = body
        self.categoryType.text = category
        self.publishedDateNews.text = date
        
        self.setupStyle()
    }
    
    private func setupStyle() {
        self.addSubview(self.imageView)
        self.addSubview(self.scrollView)
        
        self.scrollView.addSubview(self.newsTextStack)
        
        self.newsTextStack.addArrangedSubview(self.newsTitle)
        self.newsTextStack.addArrangedSubview(self.categoryType)
        self.newsTextStack.addArrangedSubview(self.newsText)
        self.newsTextStack.addArrangedSubview(self.newsSrc)
        self.newsTextStack.addArrangedSubview(self.publishedDateNews)
        
        self.newsTextStack.setCustomSpacing(400, after: self.newsSrc)
        
        self.imageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.imageView.heightAnchor.constraint(lessThanOrEqualToConstant: 200).isActive = true
        self.imageView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        
        self.scrollView.topAnchor.constraint(equalTo: self.imageView.bottomAnchor).isActive = true
        self.scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        self.scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        self.scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        
        self.newsTextStack.leadingAnchor.constraint(equalTo: self.scrollView.leadingAnchor).isActive = true
        self.newsTextStack.trailingAnchor.constraint(equalTo: self.scrollView.trailingAnchor).isActive = true
        self.newsTextStack.topAnchor.constraint(equalTo: self.scrollView.topAnchor).isActive = true
        self.newsTextStack.bottomAnchor.constraint(equalTo: self.scrollView.bottomAnchor).isActive = true
        
        self.newsTextStack.widthAnchor.constraint(equalTo: self.scrollView.widthAnchor).isActive = true
        
        self.newsText.leadingAnchor.constraint(equalTo: self.newsTextStack.leadingAnchor, constant: 12).isActive = true
        
        self.newsTitle.leadingAnchor.constraint(equalTo: self.newsTextStack.leadingAnchor, constant: 12).isActive = true
        
        self.scrollView.delegate = self
        
        self.backgroundColor = Colors.background.color
    }
}

extension NewsView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print("_LOG_ did sroll")
    }
}
