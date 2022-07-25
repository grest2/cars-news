//
//  Errors.swift
//  cars-news
//
//  Created by iOS Developer on 7/26/22.
//

import Foundation

enum AppErrors: Error {
    case request(message: String)
    case decoding(message: String)
}
