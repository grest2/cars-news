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
        let layoutItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
        let layoutItem = NSCollectionLayoutItem(layoutSize: layoutItemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(44))
        let groupItems = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [layoutItem])
        
        let layout = UICollectionViewCompositionalLayout(section: NSCollectionLayoutSection(group: groupItems))
        
        return layout
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupCollectionViewLayput()
        
        self.observeToNews()
    }
    
    private func setupCollectionViewLayput() {
        self.collectionView.register(FeedViewCell.self, forCellWithReuseIdentifier: "newsCell")
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        self.collectionView.setCollectionViewLayout(self.collectionViewLayout, animated: true)
    }
    
    private func observeToNews() {
        self.cancellableNews = self.newsViewModel.$news.sink(receiveValue: {
            [weak self] news in
            
            if news.items.count > 0 {
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
            newsCell.setNewsInfo(news: self.newsViewModel.news.items[indexPath.row].title)
            
            self.newsViewModel.getImage(index: indexPath.row) {
                newsCell.setImage(image: $0)
            }
            
            return newsCell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.newsViewModel.news.items.count
    }
}
