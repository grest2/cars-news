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
    
    private(set) var selected: [Int] = []
    
    private let requestManager: RequestManaging = RequestManager()
    
    func fetch(success: @escaping () -> Void) {
        if self.news == nil {
            Task(priority: .background) {
                do {
                    self.news = try await self.requestManager.fetchItems(type: News.self, page: 1, count: 10)
                    self.news?.page = 1
                    
                    success()
                } catch {
                    self.error = error.localizedDescription
                }
            }
        } else if let news = self.news {
            if news.items.count != news.totalCount {
                news.page += 1
                Task(priority: .background) {
                    do {
                        let fetched = try await self.requestManager.fetchItems(type: News.self, page: news.page, count: news.count)
                        
                        self.news?.count = fetched.items.count
                        self.news?.items.append(contentsOf: fetched.items)
                        
                        success()
                    } catch {
                        self.error = error.localizedDescription
                    }
                }
            }
        }
    }
    
    func addToSelected(_ id: Int) {
        self.selected.append(id)
    }
    
    func removeAt(_ i: Int) {
        self.selected.remove(at: i)
    }
}
