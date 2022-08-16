//
//  Colors.swift
//  cars-news
//
//  Created by iOS Developer on 8/16/22.
//

import Foundation
import UIKit

enum Colors {
    case newsItemMain, background
    
    var color: UIColor {
        switch self {
        case .newsItemMain:
            return UIColor.systemGray6
            
        case .background:
            return UIColor(hue: 0, saturation: 0, brightness: 0.95, alpha: 0.8)
        }
    }
}
