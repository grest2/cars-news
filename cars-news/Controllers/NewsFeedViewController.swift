//
//  ViewController.swift
//  cars-news
//
//  Created by iOS Developer on 7/25/22.
//

import UIKit
import Combine

typealias CollectionViewDelegate = UICollectionViewDelegate & UICollectionViewDataSource

class NewsFeedViewController: UIViewController {
    @IBOutlet weak var header: Header!
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var selected: NewsViewInfo?
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
        
        self.header.initialize(text: "Последние новости")
    }
    
    private func setupCollectionViewLayout() {
        self.collectionView.register(FeedViewCell.self, forCellWithReuseIdentifier: "newsCell")
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        self.collectionView.setCollectionViewLayout(self.collectionViewLayout, animated: true)
        
        self.collectionView.backgroundColor = UIColor.clear
        self.collectionView.showsVerticalScrollIndicator = false
    }
    
    private func observeToNews() {
        self.cancellableNews = self.newsViewModel.$news.sink(receiveValue: {
            [weak self] news in
            
            if news?.items.count ?? 0 > 0 {
                DispatchQueue.main.async {
                    self?.refereshCollectionView()
                }
            }
        })
    }
}

// MARK: Collection View delegate and data source implementation
extension NewsFeedViewController: CollectionViewDelegate {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? NewsViewController {
            dest.selected = self.selected
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? FeedViewCell else { return }
        
        self.selected = NewsViewInfo(title: self.newsViewModel.news?.items[indexPath.row].title ?? "Неизвестная новость",
                                     body: self.newsViewModel.news?.items[indexPath.row].description ?? "Ошибка загрузки",
                                     image: cell.image)
        
        self.performSegue(withIdentifier: "showNews", sender: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let newsCell = collectionView.dequeueReusableCell(withReuseIdentifier: "newsCell", for: indexPath) as? FeedViewCell {
            let item = self.newsViewModel.news?.items[indexPath.row]
            newsCell.setNewsInfo(news: item?.title ?? "Новость о машине", subtitle: item?.publishedDate ?? "Сегодня")
            
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
            
            self.refereshCollectionView()
        }
    }
    
    private func refereshCollectionView() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
}