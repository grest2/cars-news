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
        imageView.contentMode = .scaleAspectFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private let newsTitle: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .black
        label.numberOfLines = 0
        
        return label
    }()
    
    private var mainStack: UIStackView = {
        let stack = UIStackView()//(arrangedSubviews: [self.newsTitle, self.imageView])
        stack.distribution = .fill
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
    }
    
    /// Set data to cell
    /// - Parameter news: news title
    public func setNewsInfo(news title: String) {
        self.newsTitle.text = title
    }
    
    public func setImage(image: UIImage) {
        self.imageView.image = image
    }
    
    // MARK: private methods
    /// Set layout for news cell
    private func setupStyle() {
        self.addSubview(self.mainStack)
        
        self.mainStack.addArrangedSubview(self.newsTitle)
        self.mainStack.addArrangedSubview(self.imageView)
    }
}
