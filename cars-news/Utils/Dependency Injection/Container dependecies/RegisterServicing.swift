//
//  RegisterServicing.swift
//  cars-news
//
//  Created by iOS Developer on 7/26/22.
//

import Foundation

protocol RegisterServicing {
    func register<Service>(type: Service.Type, implementaion: Any)
    func resolve<Service>(type: Service.Type) -> Service?
}

final class RegisterService: RegisterServicing {
    static let shared: RegisterService = RegisterService()
    
    var services: [String: Any] = [:]
    
    func register<Service>(type: Service.Type, implementaion: Any) {
        services["\(type)"] = implementaion
    }
    
    func resolve<Service>(type: Service.Type) -> Service? {
        services["\(type)"] as? Service
    }
}
