//
//  RequestManager.swift
//  cars-news
//
//  Created by iOS Developer on 7/25/22.
//

import Foundation

class RequestManager: RequestManaging {
//    private let requestService: RequestServicing = RequestService()
    
    private let requestService: RequestServicing = RegisterService.shared.resolve(type: RequestServicing.self)!
    
    func fetchItems<T: Decodable>(type: T.Type) async throws -> PagedItems<T> {
        let response = try await self.requestService.get()
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
                print(error.localizedDescription)
                throw AppErrors.decoding(message: error.localizedDescription)
            }
        }
    }
}
