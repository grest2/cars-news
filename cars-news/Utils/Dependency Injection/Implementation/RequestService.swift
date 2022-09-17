//
//  RestRequestService.swift
//  cars-news
//
//  Created by iOS Developer on 7/25/22.
//

import Foundation

class RequestService: RequestServicing {
    func get(url: String) async throws -> RequestHandeledData {
        guard let url = URL(string: url) else { return RequestHandeledData.error(message: "Incorrect hosted url") }
        
        var req = URLRequest(url: url)
        req.httpMethod = "get"
        req.timeoutInterval = 20
        
        let result: Result = try await URLSession.shared.data(for: req)
        
        return self.requestResultHandling(result)
    }
    
    private func requestResultHandling(_ result: Result) -> RequestHandeledData {
        guard let response = result.response as? HTTPURLResponse else { return RequestHandeledData.error(message: "Error response cast") }
        
        switch response.statusCode {
        case 200...299:
            return RequestHandeledData.success(data: result.data)
            
        case 404:
            return RequestHandeledData.error(message: "Not found")
            
        case 500:
            return RequestHandeledData.error(message: "Internal server error")
            
        default :
            return RequestHandeledData.error(message: "Service error")
        }
    }
}
