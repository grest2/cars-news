//
//  FeedViewCell.swift
//  cars-news
//
//  Created by iOS Developer on 8/1/22.
//

import Foundation
import UIKit

final class FeedViewCell: UICollectionViewCell {
    // MARK: public props
    private(set) var id: Int = -1
    
    public weak var delegate: FeedViewCellDelegate?
    
    public var image: UIImage? {
        self.imageView.image
    }
    
    // MARK: UI props for cell
    private let imageView: NewsCellImageView = {
        let imageView = NewsCellImageView()
        imageView.image = Icons.fallback.icon
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
        self.setupGesture()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        self.setupStyle()
        self.setupGesture()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        self.imageView.cancelImageFetching()
        self.layersSetupStyle()
    }
    
    /// Set text to labels
    /// - Parameters:
    ///   - title: title of the nws
    ///   - subtitle: subtitle with published time
    public func setNewsInfo(news title: String, subtitle: String, id: Int, url: String) {
        self.newsTitle.text = title
        self.newsSubtitle.text = subtitle.formatToDate()
        self.imageView.image = Icons.fallback.icon
        self.id = id
        
        self.imageView.getImage(url: url)
    }
    
    // MARK: private methods
    /// Set layout for news cell
    private func setupStyle() {
        self.addSubview(self.newsTitle)
        
        self.newsTitle.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12).isActive = true
        self.newsTitle.topAnchor.constraint(equalTo: self.topAnchor, constant: 12).isActive = true
        self.newsTitle.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -8).isActive = true
        
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
    
    private func setupGesture() {
        let longTap = UILongPressGestureRecognizer(target: self, action: #selector(onLongTap))
        self.addGestureRecognizer(longTap)
    }
    
    /// Set up layers style for shadow and border
    private func layersSetupStyle() {
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 12
        self.layer.borderColor = UIColor.clear.cgColor
        
        self.shadowLayerCellSetup()
    }
    
    @objc private func onLongTap() {
        self.delegate?.onLongTimePressure(id: self.id)
        
        self.selectionAnimating()
    }
}
