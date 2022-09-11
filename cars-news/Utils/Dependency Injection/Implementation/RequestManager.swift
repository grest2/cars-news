//
//  RequestManager.swift
//  cars-news
//
//  Created by iOS Developer on 7/25/22.
//

import Foundation
import UIKit

class RequestManager: RequestManaging {
    private let requestService: RequestServicing = DependencyContainer.resolve()
    
    func fetchItems<T: Decodable>(type: T.Type, page: Int, count: Int) async throws -> PagedItems<T> {
        let response = try await self.requestService.get(url: "https://webapi.autodoc.ru/api/news/\(page)/\(count)")
        
        switch response {
        case .error(let message):
            throw AppErrors.request(message: message)
        case .success(let data):
            do {
                let items = try JSONDecoder().decode(PagedItems<T>.self, from: data)
                return items
            } catch DecodingError.dataCorrupted(let context) {
                throw AppErrors.decoding(message: "Type corrupted, context: \(context.debugDescription)")
            } catch DecodingError.typeMismatch(let type, let context) {
                throw AppErrors.decoding(message: "Type missmatch, type: \(type), context: \(context.debugDescription)")
            } catch DecodingError.valueNotFound(let type, let context) {
                throw AppErrors.decoding(message: "Decoding error, value not found, type: \(type), context: \(context.debugDescription)")
            } catch {
                throw AppErrors.decoding(message: error.localizedDescription)
            }
        }
    }
    
    func getImage(url: String) async throws -> UIImage {
        let response = try await self.requestService.get(url: url)
        
        switch response {
        case .error(let message):
            throw AppErrors.request(message: message)
        case .success(let data):
            if let image = UIImage(data: data) {
                return image
            }
            
            throw AppErrors.imageInit
        }
    }
}
