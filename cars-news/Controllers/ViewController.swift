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
    
    private var news: [News] = []
    
    private var cancellableNews: AnyCancellable?
    
    private let newsViewModel: NewsViewModel = NewsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.newsViewModel.fetch()
        
        self.collectionView.register(FeedViewCell.self, forCellWithReuseIdentifier: "newsCell")
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.sectionInset = UIEdgeInsets(top: 1, left: 1, bottom: 1, right: 1)
        layout.minimumLineSpacing = 1.0
        layout.minimumInteritemSpacing = 1.0
        self.collectionView.setCollectionViewLayout(layout, animated: true)
        
        self.cancellableNews = self.newsViewModel.$news.sink(receiveValue: {
            [weak self] news in
            
            self?.news = news.items
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        })
    }
}

// MARK: Collection View delegate and data source implementation
extension ViewController: CollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let newsCell = collectionView.dequeueReusableCell(withReuseIdentifier: "newsCell", for: indexPath) as? FeedViewCell {
            newsCell.setNewsInfo(news: self.news[indexPath.row])
            
            return newsCell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.news.count
    }
}
