//
//  StringExtension.swift
//  cars-news
//
//  Created by iOS Developer on 8/4/22.
//

import Foundation

extension String {
    /// Converting string date to format date
    /// - Parameter format: format for converting
    /// - Returns: formatted date string
    func formatToDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        
        let converted = formatter.date(from: self)
        formatter.timeStyle = .none
        
        
        return converted?.formatted() ?? "Недавно"
    }
}
