//
//  NewsCellImageView.swift
//  cars-news
//
//  Created by iOS Developer on 9/6/22.
//

import Foundation
import UIKit

final class NewsCellImageView: UIImageView {
    private var imageTask: Task<UIImage, Error>?
    
    private let requestManager: RequestManaging = DependencyContainer.resolve()
    
    func getImage(url: String, id: Int) {
        image = Icons.fallback.icon
        
        Task(priority: .high) {
            let image = await self.getImage(url: url, id: id)
            
            DispatchQueue.main.async {
                self.image = image
            }
        }
    }
    
    private func getImage(url: String, id: Int) async -> UIImage? {
        self.imageTask = Task(priority: .high) {
            [weak self] in
            guard let self = self else { return Icons.goBack.icon! }
            do {
                let image = try await self.requestManager.getImage(url: url)
                
                return image
            } catch {
                throw error
            }
        }
        
        return try? await self.imageTask?.value
    }
    
    func cancelImageFetching() {
        self.imageTask?.cancel()
        self.imageTask = nil
    }
}
