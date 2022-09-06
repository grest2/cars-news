//
//  NetworkUtils.swift
//  cars-news
//
//  Created by iOS Developer on 7/25/22.
//

import Foundation
import UIKit

// MARK: Typealiases
typealias Result = (data: Data, response: URLResponse)

// MARK: Enums
enum RequestHandeledData {
    case error(message: String)
    case success(data: Data)
}



enum Icons {
    case goBack
    
    var icon: UIImage? {
        switch self {
        case .goBack:
            return UIImage(named: "arrow.left.circle")
        }
    }
}

// MARK: utilities for helping
class Utilities {
    /// Funxc helper for checking fetching items pagination
    /// - Parameters:
    ///   - totalItems: total items count
    ///   - page: page number for list items
    ///   - countOfItems: count fetched items
    /// - Returns: true or false for fetching
    static func shouldFetch(totalItems: Int, page: Int, countOfItems: Int) -> Bool {
        page * countOfItems < totalItems
    }
}
