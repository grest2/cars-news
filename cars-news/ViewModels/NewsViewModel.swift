//
//  NewsViewModel.swift
//  cars-news
//
//  Created by iOS Developer on 7/28/22.
//

import Foundation
import UIKit

@MainActor final class NewsViewModel: ObservableObject {
    // MARK: Published props
    @Published private(set) var news: PagedItems<News>?
    @Published private(set) var error: String?
    
    private let requestManager: RequestManaging = DependencyContainer.resolve()
    
    init() {
        self.fetch()
    }
    
    func fetch() {
        if self.news == nil {
            Task(priority: .background) {
                do {
                    self.news = try await self.requestManager.fetchItems(type: News.self, page: 1, count: 15)
                } catch {
                    self.error = error.localizedDescription
                }
            }
        } else if let news = self.news {
            if Utilities.shouldFetch(totalItems: news.totalCount, page: news.page, countOfItems: news.count) {
                news.page += 1
                Task(priority: .background) {
                    do {
                        let fetched = try await self.requestManager.fetchItems(type: News.self, page: news.page, count: news.count)
                        
                        self.news?.count = fetched.items.count
                        self.news?.items.append(contentsOf: fetched.items)
                    } catch {
                        self.error = error.localizedDescription
                    }
                }
            }
        }
    }
}
