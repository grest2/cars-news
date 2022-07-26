//
//  InjectedValues.swift
//  cars-news
//
//  Created by iOS Developer on 7/26/22.
//

import Foundation

struct InjectedValues {
    private static var current = InjectedValues()
    
    static subscript<T>(key: T.Type) -> T.Value where T: InjectionKey {
        get { key.current }
        set { key.current = newValue }
    }
    
    static subscript<T>(_ keyPath: WritableKeyPath<InjectedValues, T>) -> T {
        get { current[keyPath: keyPath] }
        set { current[keyPath: keyPath] = newValue }
    }
}

extension InjectedValues {
    var requestServicingProvider: RequestServicing {
        get { Self[RequestServicingKey.self] }
        set { Self[RequestServicingKey.self] = newValue }
    }
}
