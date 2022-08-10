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
        imageView.layer.cornerRadius = 12
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFit
        
        return imageView
    }()
    
    private let newsTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .black
        label.numberOfLines = 0
        
        return label
    }()
    
    private let newsSubtitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .gray
        label.numberOfLines = 0
        
        return label
    }()
    
    private var labelsStack: UIStackView = {
        let stack = UIStackView()
        stack.distribution = .equalCentering
        stack.spacing = 4
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.setBorder(color: .red)
        
        return stack
    }()
    
    private var mainStack: UIStackView = {
        let stack = UIStackView()
        stack.distribution = .fillEqually
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.setBorder(color: .blue)
        
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
    }
    
    // MARK: private methods
    
    /// Set layout for news cell
    private func setupStyle() {
        self.labelsStack.addArrangedSubview(self.newsTitle)
        self.labelsStack.addArrangedSubview(self.newsSubtitle)
        
        self.mainStack.addArrangedSubview(self.labelsStack)
        self.mainStack.addArrangedSubview(self.imageView)
        
        self.addSubview(self.mainStack)
        
        self.mainStack.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        self.mainStack.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.mainStack.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        self.mainStack.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }
}
