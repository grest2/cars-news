//
//  RequestManaging.swift
//  cars-news
//
//  Created by iOS Developer on 7/25/22.
//

import Foundation

protocol RequestManaging {
    func fetchItems<T: Decodable>(type: T.Type) async throws -> PagedItems<T>
}
