//
//  RequestManager.swift
//  cars-news
//
//  Created by iOS Developer on 7/25/22.
//

import Foundation

enum AppErrors: Error {
    case request(message: String)
    case decoding(message: String)
}

class RequestManager: RequestManaging {
    private let requestService: RequestServicing = RequestService()
    
    func fetchItems<T: Decodable>() async throws -> [T] {
        let response = try await self.requestService.get()
        
        switch response {
        case .error(let message):
            throw AppErrors.request(message: message)
        case .success(let data):
            let items = try JSONDecoder().decode([T].self, from: data)
            return items
        }
    }
}
