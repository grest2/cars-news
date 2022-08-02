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
    @Published private(set) var news: PagedItems<News> = PagedItems<News>()
    
    @Published private(set) var error: String?
    
    private let requestManager: RequestManaging = DependencyContainer.resolve()
    
    init() {
        self.fetch()
    }
    
    func fetch() {
        Task(priority: .background) {
            do {
                self.news = try await self.requestManager.fetchItems(type: News.self)
            } catch {
                self.error = error.localizedDescription
            }
        }
    }
    
    func getImage(index: Int, completion: @escaping (UIImage) -> Void) {
        let url = self.news.items[index].titleImageUrl
        
        Task(priority: .background) {
            do {
                let image = try await self.requestManager.getImage(url: url)
                
                completion(image)
            } catch {
                self.error = error.localizedDescription
            }
        }
    }
}
