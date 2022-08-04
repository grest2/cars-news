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
    func formatToDate(format: String = "mm/dd/yyyy") -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        
        let converted = formatter.date(from: self) ?? Date()
        return converted.formatted()
    }
}
