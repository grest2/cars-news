//
//  RequestManaging.swift
//  cars-news
//
//  Created by iOS Developer on 7/25/22.
//

import Foundation
import UIKit

protocol RequestManaging {
    func fetchItems<T: Decodable>(type: T.Type, page: Int, count: Int) async throws -> PagedItems<T>
    
    func getImage(url: String) async throws -> UIImage
}
