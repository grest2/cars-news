//
//  Colors.swift
//  cars-news
//
//  Created by iOS Developer on 8/16/22.
//

import Foundation
import UIKit

enum Colors {
    case newsItemMain, background, newsCellShadow, headerBackground, secondary, light
    
    var color: UIColor {
        switch self {
        case .newsItemMain:
            return UIColor.systemGray6
            
        case .headerBackground:
            return UIColor(red: 1, green: 93/255, blue: 93/255, alpha: 1)
            
        case .secondary:
            return UIColor(red: 1, green: 195/255, blue: 195/255, alpha: 1)
            
        case .background:
            return UIColor(red: 1, green: 231/255, blue: 191/255, alpha: 1)
        
        case .light:
            return UIColor(red: 1, green: 140/255, blue: 140/255, alpha: 1)
            
        case .newsCellShadow:
            return UIColor(red: 161/255, green: 0, blue: 53/255, alpha: 0.8)
        }
    }
}
