//
//  RequestServicingKey.swift
//  cars-news
//
//  Created by iOS Developer on 7/26/22.
//

import Foundation

struct RequestServicingKey: InjectionKey {
    static var current: RequestServicing = RequestService()
}
