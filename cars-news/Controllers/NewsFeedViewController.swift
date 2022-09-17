//
//  ViewController.swift
//  cars-news
//
//  Created by iOS Developer on 7/25/22.
//

import UIKit
import Combine

typealias CollectionViewDelegate = UICollectionViewDelegate

final class NewsFeedViewController: UIViewController {
    @IBOutlet weak var header: Header!
    @IBOutlet weak var errorCard: ErrorCard!
    @IBOutlet weak var collectionView: UICollectionView!
    
    private lazy var diffableDataSource: UICollectionViewDiffableDataSource<SectionNewsFeed, News> = self.initializeDataSource(collectionView: self.collectionView)
    
    private var selected: NewsViewInfo?
    
    private var cancellableNews: AnyCancellable?
    private var cancellableError: AnyCancellable?
    
    private let newsViewModel: NewsViewModel = NewsViewModel()
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        
        spinner.color = Colors.newsCellShadow.color
        
        return spinner
    }()
    
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
        
        self.newsViewModel.fetch() {
            self.updateSnapshot()
            self.spinner.stopAnimating()
        }
        
        self.addSpinner()
        self.setupCollectionViewLayout()
        self.errorCard.initialize()
        
        self.observeToNews()
        
        self.view.backgroundColor = Colors.background.color
        
        self.header.initialize(text: "Последние новости")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.cancellableError?.cancel()
        self.cancellableNews?.cancel()
    }
    
    // MARK: private methods of news feed view controller
    private func setupCollectionViewLayout() {
        self.collectionView.register(FeedViewCell.self, forCellWithReuseIdentifier: "newsCell")
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self.diffableDataSource
        
        self.collectionView.setCollectionViewLayout(self.collectionViewLayout, animated: true)
        
        self.collectionView.backgroundColor = UIColor.clear
        self.collectionView.showsVerticalScrollIndicator = false
    }
    
    private func observeToNews() {
        self.cancellableError = self.newsViewModel.$error.sink(receiveValue: {
            [weak self] error in
            
            if let error = error, let self = self {
                self.showError(error: error)
            }
        })
    }
    
    private func addSpinner() {
        self.spinner.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(self.spinner)
        
        self.spinner.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        self.spinner.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
        self.view.bringSubviewToFront(self.spinner)
        
        self.spinner.startAnimating()
    }
    
    private func showError(error: String) {
        self.errorCard.isHidden = false
        
        self.errorCard.show(error: error)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.errorCard.isHidden = true
        }
    }
    
    private func updateSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<SectionNewsFeed, News>()
        snapshot.appendSections([.default])
        snapshot.appendItems(self.newsViewModel.news?.items ?? [], toSection: .default)
        
        self.diffableDataSource.apply(snapshot, animatingDifferences: true)
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
        
        let i = indexPath.row
        
        self.selected = NewsViewInfo(title: self.newsViewModel.news?.items[i].title,
                                     body: self.newsViewModel.news?.items[i].description,
                                     category: self.newsViewModel.news?.items[i].categoryType,
                                     publishedDate: self.newsViewModel.news?.items[i].publishedDate,
                                     fullUrl: self.newsViewModel.news?.items[i].fullUrl,
                                     image: cell.image)
        
        cell.selectionAnimating {
            self.performSegue(withIdentifier: "showNews", sender: nil)
        }
    }
    
    func initializeDataSource(collectionView: UICollectionView) -> UICollectionViewDiffableDataSource<SectionNewsFeed, News> {
        let dataSource = UICollectionViewDiffableDataSource<SectionNewsFeed, News>(collectionView: self.collectionView) {
            (collectionView, indexPath, info) -> UICollectionViewCell? in
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "newsCell", for: indexPath) as? FeedViewCell {
                cell.setNewsInfo(news: info.title, subtitle: info.publishedDate, id: info.id, url: info.titleImageUrl)
                return cell
            }
            
            return UICollectionViewCell()
        }
        
        return dataSource
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.newsViewModel.news?.items.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row == (self.newsViewModel.news?.items.count ?? 0) - 1 {
            self.spinner.startAnimating()
            self.newsViewModel.fetch() {
                self.updateSnapshot()
                self.spinner.stopAnimating()
            }
        }
    }
}

