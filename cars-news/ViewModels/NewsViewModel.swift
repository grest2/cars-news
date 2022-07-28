//
//  NewsViewModel.swift
//  cars-news
//
//  Created by iOS Developer on 7/28/22.
//

import Foundation

@MainActor final class NewsViewModel: ObservableObject {
    // MARK: Published props
    @Published private(set) var news: PagedItems<News> = PagedItems<News>()
    
    @Published private(set) var error: String?
    
    private let requestManager: RequestManaging = DependencyContainer.resolve()
    
    func fetch() {
        Task(priority: .background) {
            do {
                self.news = try await self.requestManager.fetchItems(type: News.self)
            } catch {
                self.error = error.localizedDescription
            }
        }
    }
}
