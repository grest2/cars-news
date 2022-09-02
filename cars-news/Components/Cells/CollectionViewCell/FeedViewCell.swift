//
//  FeedViewCell.swift
//  cars-news
//
//  Created by iOS Developer on 8/1/22.
//

import Foundation
import UIKit

final class FeedViewCell: UICollectionViewCell {
    // MARK: UI props for cell
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 12
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.layer.maskedCorners = [.layerMinXMaxYCorner, .layerMaxXMaxYCorner]
        
        return imageView
    }()
    
    private let newsTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .black
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakMode = .byTruncatingTail
        
        return label
    }()
    
    private let newsSubtitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private var mainStack: UIStackView = {
        let stack = UIStackView()
        stack.distribution = .fillEqually
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        return stack
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupStyle()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.setupStyle()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.imageView.isHidden = true
    }
    
    /// Set text to labels
    /// - Parameters:
    ///   - title: title of the nws
    ///   - subtitle: subtitle with published time
    public func setNewsInfo(news title: String, subtitle: String) {
        self.newsTitle.text = title
        self.newsSubtitle.text = subtitle.formatToDate()
    }
    
    /// Set image for news cell
    /// - Parameter image: downloaded image by url from model
    public func setImage(image: UIImage) {
        self.imageView.image = image
        
        self.imageView.isHidden = false
    }
    
    // MARK: private methods
    
    /// Set layout for news cell
    private func setupStyle() {
        self.addSubview(self.newsTitle)
        
        self.newsTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12).isActive = true
        self.newsTitle.topAnchor.constraint(equalTo: self.topAnchor, constant: 12).isActive = true
        self.newsTitle.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 8).isActive = true
        
        self.addSubview(self.newsSubtitle)
        
        self.newsSubtitle.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12).isActive = true
        self.newsSubtitle.topAnchor.constraint(equalTo: self.newsTitle.bottomAnchor, constant: 8).isActive = true
        
        self.mainStack.addArrangedSubview(self.imageView)
        
        self.addSubview(self.mainStack)
        
        self.mainStack.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        self.mainStack.topAnchor.constraint(equalTo: self.newsSubtitle.bottomAnchor, constant: 12).isActive = true
        self.mainStack.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        self.mainStack.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        
        self.mainStack.backgroundColor = .clear
        
        self.layersSetupStyle()
        
        self.backgroundColor = Colors.newsItemMain.color
    }
    
    /// Set up layers style for shadow and border
    private func layersSetupStyle() {
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 12
        self.layer.borderColor = Colors.newsCellShadow.color.cgColor//UIColor.lightGray.cgColor
        
        self.layer.shadowColor = Colors.newsCellShadow.color.cgColor//UIColor.darkGray.cgColor
        self.layer.shadowOpacity = 1
        self.layer.shadowOffset = CGSize(width: -2, height: 4)
        self.layer.shadowRadius = 4
    }
}
