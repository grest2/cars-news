//
//  InjectionKey.swift
//  cars-news
//
//  Created by iOS Developer on 7/26/22.
//

import Foundation

public protocol InjectionKey {
    associatedtype Value
    
    static var current: Self.Value { get set }
}

