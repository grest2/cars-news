//
//  News.swift
//  cars-news
//
//  Created by iOS Developer on 7/25/22.
//

import Foundation

struct News: Decodable, Hashable {
    var id: Int
    var title: String
    var description: String
    var publishedDate: String
    var url: String
    var fullUrl: String
    var titleImageUrl: String
    var categoryType: String
}
