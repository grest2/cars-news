//
//  PagedItems.swift
//  cars-news
//
//  Created by iOS Developer on 7/26/22.
//

import Foundation

class PagedItems<T: Decodable>: Decodable {
    var totalCount: Int
    var items: [T]
    
    var count: Int = 15
    var page: Int = 1
    
    enum CodingKeys: String, CodingKey {
        case totalCount
        case items = "news"
    }
    
    init() {
        self.totalCount = 0
        self.items = []
    }
}
