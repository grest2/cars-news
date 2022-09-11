//
//  StringExtension.swift
//  cars-news
//
//  Created by iOS Developer on 8/4/22.
//

import Foundation

extension String {
    // MARK: added funcs
    /// Converting string date to format date
    /// - Parameter format: format for converting
    /// - Returns: formatted date string
    func formatToDate() -> String {
        self.count > 10 ? self[0..<10].replacingOccurrences(of: "-", with: ".") : "Недавно"
    }
    
    // MARK: subscripts
    subscript(r: Range<Int>) -> String {
        let range = Range(uncheckedBounds: (lower: max(0, min(self.count, r.lowerBound)),
                                            upper: min(self.count, max(0, r.upperBound))))
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(start, offsetBy: range.upperBound - range.lowerBound)
        return String(self[start..<end])
    }
}
