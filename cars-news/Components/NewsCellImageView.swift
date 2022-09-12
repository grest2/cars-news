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
    
    @MainActor
    func getImage(url: String) {
        image = Icons.fallback.icon
        
        Task {
            let image = await self.getImage(url: url)
            
            DispatchQueue.main.async {
                self.image = image
            }
        }
    }
    
    private func getImage(url: String) async -> UIImage? {
        self.imageTask = Task(priority: .background) {
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
