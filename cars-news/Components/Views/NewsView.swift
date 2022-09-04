//
//  NewsView.swift
//  cars-news
//
//  Created by iOS Developer on 9/2/22.
//

import Foundation
import UIKit

final class NewsView: UIView {
    private var srcUrl: String = ""
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 22
        imageView.clipsToBounds = true
        imageView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        imageView.isUserInteractionEnabled = true
        
        return imageView
    }()
    
    private let newsTextStack: UIStackView = {
        let stack = UIStackView()
        stack.distribution = .equalSpacing
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 8
        stack.alignment = .leading
        
        return stack
    }()
    
    private let newsBodyStack: UIStackView = {
        let stack = UIStackView()
        stack.distribution = .equalSpacing
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.spacing = 8
        
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
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = Colors.newsCellShadow.color
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        
        return label
    }()
    
    private let srcNewsButton: UIButton = {
        let button = UIButton(type: .system)
        
        button.layer.cornerRadius = 12
        button.backgroundColor = Colors.newsCellShadow.color
        button.clipsToBounds = true
        button.setTitle("Подробнее...", for: .normal)
        button.tintColor = .systemGray5
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.titleEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        button.isUserInteractionEnabled = true
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    private let categoryType: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .systemGray5
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        
        return label
    }()
    
    private let publishedDateNews: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = Colors.newsCellShadow.color
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        
        return label
    }()
    
    public func initialize(image: UIImage?, title: String, body: String, date: String, fullUrl: String, category: String) {
        self.imageView.image = image
        self.newsTitle.text = title
        self.newsText.text = body
        self.categoryType.text = category
        self.publishedDateNews.text = "Дата размещения: \(date.formatToDate())"
        self.srcUrl = fullUrl
        
        
        self.setupStyle()
    }
    
    // MARK: private methods
    /// Setup layout for view
    private func setupStyle() {
        self.addSubview(self.imageView)
        self.imageView.addSubview(self.newsTextStack)
        self.addSubview(self.newsBodyStack)
        
        self.newsTextStack.addArrangedSubview(self.newsTitle)
        self.newsTextStack.addArrangedSubview(self.categoryType)
        self.newsTextStack.addArrangedSubview(self.srcNewsButton)
        
        self.newsBodyStack.addArrangedSubview(self.newsText)
        self.newsBodyStack.addArrangedSubview(self.publishedDateNews)
        
        self.srcNewsButton.addTarget(self, action: #selector(self.openNewsSrc(_:)), for: .touchUpInside)
        
        self.imageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.imageView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        self.imageView.heightAnchor.constraint(lessThanOrEqualToConstant: UIScreen.main.bounds.height * 0.6).isActive = true
        
        self.newsTextStack.leadingAnchor.constraint(equalTo: self.imageView.leadingAnchor, constant: 6).isActive = true
        self.newsTextStack.trailingAnchor.constraint(equalTo: self.imageView.trailingAnchor, constant: -6).isActive = true
        self.newsTextStack.bottomAnchor.constraint(equalTo: self.imageView.bottomAnchor, constant: -12).isActive = true
        self.newsTextStack.widthAnchor.constraint(equalTo: self.imageView.widthAnchor).isActive = true
        
        self.newsBodyStack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 6).isActive = true
        self.newsBodyStack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -6).isActive = true
        self.newsBodyStack.topAnchor.constraint(equalTo: self.imageView.bottomAnchor, constant: 12).isActive = true
        
        self.srcNewsButton.leadingAnchor.constraint(equalTo: self.newsTextStack.leadingAnchor).isActive = true
        
        self.backgroundColor = Colors.background.color
    }
    
    @objc func openNewsSrc(_ sender: UIButton) {
        guard let url = URL(string: self.srcUrl) else { return }
        
        UIApplication.shared.open(url)
    }
}
