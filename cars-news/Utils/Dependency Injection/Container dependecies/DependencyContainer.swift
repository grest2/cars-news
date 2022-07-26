//
//  DependencyContainer.swift
//  cars-news
//
//  Created by iOS Developer on 7/26/22.
//

import Foundation

class DependencyContainer {
    private static let registerService: RegisterServicing = RegisterService.shared
    
    // Регистрация зависимостей
    static func register() {
        self.registerService.register(type: RequestServicing.self, implementaion: RequestService())
        
        self.registerService.register(type: RequestManaging.self, implementaion: RequestManager())
    }
    
    static func resolve<T>() -> T {
        self.registerService.resolve(type: T.self)!
    }
}
