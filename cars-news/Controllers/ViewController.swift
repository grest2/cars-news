//
//  ViewController.swift
//  cars-news
//
//  Created by iOS Developer on 7/25/22.
//

import UIKit
import Combine

typealias CollectionViewDelegate = UICollectionViewDelegate & UICollectionViewDataSource

class ViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var cancellableNews: AnyCancellable?
    
    private let newsViewModel: NewsViewModel = NewsViewModel()
    
    private let collectionViewLayout: UICollectionViewLayout = {
        let layoutItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalWidth(2/3))
        let layoutItem = NSCollectionLayoutItem(layoutSize: layoutItemSize)
        layoutItem.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 12, bottom: 12, trailing: 0)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalWidth(2/3))
        let groupItems = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [layoutItem])
        
        let sectionLayout = NSCollectionLayoutSection(group: groupItems)
        
        let layout = UICollectionViewCompositionalLayout(section: sectionLayout)
        
        return layout
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupCollectionViewLayout()
        
        self.observeToNews()
        
        self.view.backgroundColor = Colors.background.color
    }
    
    private func setupCollectionViewLayout() {
        self.collectionView.register(FeedViewCell.self, forCellWithReuseIdentifier: "newsCell")
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        self.collectionView.setCollectionViewLayout(self.collectionViewLayout, animated: true)
        
        self.collectionView.backgroundColor = UIColor.clear
    }
    
    private func observeToNews() {
        self.cancellableNews = self.newsViewModel.$news.sink(receiveValue: {
            [weak self] news in
            
            if news?.items.count ?? 0 > 0 {
                DispatchQueue.main.async {
                    self?.collectionView.reloadData()
                }
            }
        })
    }
}

// MARK: Collection View delegate and data source implementation
extension ViewController: CollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let newsCell = collectionView.dequeueReusableCell(withReuseIdentifier: "newsCell", for: indexPath) as? FeedViewCell {
            let item = self.newsViewModel.news?.items[indexPath.row]
            newsCell.setNewsInfo(news: item?.title ?? "Car title new", subtitle: item?.publishedDate ?? "Today")
            
            self.newsViewModel.getImage(index: indexPath.row) {
                newsCell.setImage(image: $0)
            }
            
            return newsCell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.newsViewModel.news?.items.count ?? 0
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let height = scrollView.frame.size.height
        
        let bottomDistance = scrollView.contentSize.height - scrollView.contentOffset.y
        
        if bottomDistance < height {
            self.newsViewModel.fetch()
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
}
