//
//  NetworkUtils.swift
//  cars-news
//
//  Created by iOS Developer on 7/25/22.
//

import Foundation

// MARK: Typealiases
typealias Result = (data: Data, response: URLResponse)

// MARK: Enums
enum RequestHandeledData {
    case error(message: String)
    case success(data: Data)
}
