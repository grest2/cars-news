//
//  RequestService.swift
//  cars-news
//
//  Created by iOS Developer on 7/25/22.
//

import Foundation

protocol RequestServicing {
    func get(url: String) async throws -> RequestHandeledData
}
