//
//  ViewController.swift
//  cars-news
//
//  Created by iOS Developer on 7/25/22.
//

import UIKit
import Combine

typealias CollectionViewDelegate = UICollectionViewDelegate
typealias NewsDataSource = UICollectionViewDiffableDataSource<SectionNewsFeed, News>

final class NewsFeedViewController: UIViewController, FeedViewCellDelegate {
    @IBOutlet weak var header: Header!
    @IBOutlet weak var errorCard: ErrorCard!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    @IBOutlet weak var bottomSpinnerConstraint: NSLayoutConstraint!
    @IBOutlet weak var centerYspinnerConstraint: NSLayoutConstraint!
    
    private lazy var diffableDataSource: NewsDataSource = self.initializeDataSource(collectionView: self.collectionView)
    
    private var selected: NewsViewInfo?
    
    private var cancellableError: AnyCancellable?
    
    private let newsViewModel: NewsViewModel = NewsViewModel()
    
    private let collectionViewLayout: UICollectionViewLayout = {
        let layoutItemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let layoutItem = NSCollectionLayoutItem(layoutSize: layoutItemSize)
        layoutItem.contentInsets = NSDirectionalEdgeInsets(top: 12, leading: 16, bottom: 12, trailing: 16)
        
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
        
        self.setupSpinner()
        self.setupCollectionViewLayout()
        self.errorCard.initialize()
        
        self.observeToNews()
        
        self.view.backgroundColor = Colors.headerBackground.color
        
        self.header.initialize(text: "Последние новости")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.cancellableError?.cancel()
    }
    
    override func viewDidLayoutSubviews() {
        if self.newsViewModel.news != nil && self.centerYspinnerConstraint.isActive {
            self.centerYspinnerConstraint.isActive = false
            self.bottomSpinnerConstraint.isActive = true
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? NewsViewController {
            dest.selected = self.selected
        }
    }
    
    // MARK: private methods of news feed view controller
    private func setupCollectionViewLayout() {
        self.collectionView.register(FeedViewCell.self, forCellWithReuseIdentifier: "newsCell")
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self.diffableDataSource
        
        self.collectionView.setCollectionViewLayout(self.collectionViewLayout, animated: true)
        
        self.collectionView.backgroundColor = Colors.background.color
        self.collectionView.showsVerticalScrollIndicator = false
    }
    
    private func setupSpinner() {
        self.spinner.hidesWhenStopped = true
        self.spinner.color = Colors.newsCellShadow.color
        self.spinner.startAnimating()
    }
    
    private func updateSnapshot() {
        var snapshot = NSDiffableDataSourceSnapshot<SectionNewsFeed, News>()
        snapshot.appendSections([.default])
        snapshot.appendItems(self.newsViewModel.news?.items ?? [], toSection: .default)
        
        self.diffableDataSource.apply(snapshot, animatingDifferences: true)
    }
    
    // MARK: View managament and utils
    private func showError(error: String) {
        self.errorCard.isHidden = false
        
        self.errorCard.show(error: error)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.errorCard.isHidden = true
        }
    }
    
    private func observeToNews() {
        self.cancellableError = self.newsViewModel.$error.sink(receiveValue: {
            [weak self] error in
            
            if let error = error, let self = self {
                self.showError(error: error)
            }
        })
    }
}

// MARK: Collection View delegate and data source implementation
extension NewsFeedViewController: CollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? FeedViewCell else { return }
        
        if let index = self.newsViewModel.selected.firstIndex(of: (self.newsViewModel.news?.items ?? [])[indexPath.row].id) {
            self.newsViewModel.removeAt(index)
        } else {
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
    }
    
    func initializeDataSource(collectionView: UICollectionView) -> NewsDataSource {
        let dataSource = UICollectionViewDiffableDataSource<SectionNewsFeed, News>(collectionView: self.collectionView) {
            (collectionView, indexPath, info) -> UICollectionViewCell? in
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "newsCell", for: indexPath) as? FeedViewCell {
                cell.setNewsInfo(news: info.title, subtitle: info.publishedDate, id: info.id, url: info.titleImageUrl)
                cell.delegate = self
                if self.newsViewModel.selected.contains(info.id) {
                    cell.layer.shadowColor = Colors.newsCellShadow.color.cgColor
                }
                return cell
            }
            
            return UICollectionViewCell()
        }
        
        return dataSource
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
// MARK: Collection view custom delegates methods implementation
extension NewsFeedViewController {
    func onLongTimePressure(id: Int) {
        if let _ = self.newsViewModel.selected.firstIndex(of: id) {
            return
        } else {
            self.newsViewModel.addToSelected(id)
        }
    }
}

