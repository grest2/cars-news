//
//  DiffableDataSource.swift
//  cars-news
//
//  Created by iOS Developer on 9/17/22.
//

import Foundation
import UIKit

enum SectionNewsFeed {
    case `default`
}

enum SectionItem {
    case info(News)
}

extension SectionItem: Hashable {
    static func == (lhs: SectionItem, rhs: SectionItem) -> Bool {
        lhs.hashValue == rhs.hashValue
    }
    
    func hash(into hasher: inout Hasher) {
        switch self {
        case .info(let news):
            hasher.combine(news.id)
        }
    }
}

final class NewsFeedDiffableDataSource: UICollectionViewDiffableDataSource<SectionNewsFeed, News> {
    init(collectionView: UICollectionView) {
        super.init(collectionView: collectionView) {
            (collectionView, indexPath, info) -> UICollectionViewCell? in
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "newsCell", for: indexPath) as? FeedViewCell {
                cell.setNewsInfo(news: info.title, subtitle: info.publishedDate, id: info.id, url: info.titleImageUrl)
                
                return cell
            }
            
            return UICollectionViewCell()
        }
    }
}
