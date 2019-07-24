//
//  Category.swift
//  sizecalculator
//
//  Created by Simon Kostenko on 7/24/19.
//  Copyright © 2019 ANODA. All rights reserved.
//

import Foundation
import UIKit

struct Dress {
    
    enum Category: CaseIterable {
        case evening
        case prom
        case bridesmaids
        case bridal
        case vipBridal
        case mob
        case cocktail
        
        var name: String {
            switch self {
            case .evening:
                return "Evening Dress"
            case .prom:
                return "Prom Dress"
            case .bridesmaids:
                return "Bridesmaid"
            case .bridal:
                return "Bridal Dress"
            case .vipBridal:
                return "VIP Bridal Dress"
            case .mob:
                return "MOB"
            case .cocktail:
                return "Cocktail Dress"
            }
        }
    }
    
    enum Status {
        case inStock
        case inProduction
        case forwardOrder
    }
    
    let category: Category
    let size: Size
    let color: UIColor
    let status: Status
}
