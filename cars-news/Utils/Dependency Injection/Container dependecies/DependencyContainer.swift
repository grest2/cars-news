//
//  DependencyContainer.swift
//  cars-news
//
//  Created by iOS Developer on 7/26/22.
//

import Foundation

class DependencyContainer {
    private let registerService: RegisterServicing = RegisterService.shared
    
    // Регистрация зависимостей
    func register() {
        self.registerService.register(type: RequestServicing.self, implementaion: RequestService())
        
        self.registerService.register(type: RequestManaging.self, implementaion: RequestManager())
    }
}
