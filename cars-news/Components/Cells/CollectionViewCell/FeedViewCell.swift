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
    private let mainStack: UIStackView = UIStackView()
    private let newsHeader: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: 25, height: 16))
    private let newsImage: UIImageView = UIImageView()
    
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
    /// - Parameter news: news model
    public func setNewsInfo(news: News) {
        self.newsHeader.text = news.title
    }
    
    /// Set layout for news cell
    private func setupStyle() {
        self.setupHeaderText()
        
        self.mainStack.axis = .vertical
        
        self.newsHeader.translatesAutoresizingMaskIntoConstraints = false
        
        self.mainStack.addArrangedSubview(self.newsHeader)
        
        self.newsHeader.leftAnchor.constraint(equalTo: self.mainStack.leftAnchor).isActive = true
        self.newsHeader.rightAnchor.constraint(equalTo: self.mainStack.rightAnchor).isActive = true
        
        self.mainStack.addArrangedSubview(self.newsImage)
        
        self.addSubview(self.mainStack)
        self.newsHeader.setBorder(color: .red)
    }
    
    private func setupHeaderText() {
        self.newsHeader.font = UIFont.boldSystemFont(ofSize: 16)
        self.newsHeader.textColor = .black
    }
}


extension UIView {
    func setBorder(color: UIColor, width: CGFloat = 1) {
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = width
    }
}
