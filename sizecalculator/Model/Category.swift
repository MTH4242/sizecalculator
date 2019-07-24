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
    
    enum Category: String, Codable, CaseIterable {
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
    
    enum Status: String, Codable {
        case inStock
        case inProduction
        case forwardOrder
    }
    
    enum Color: String, Codable {
        case red
        case green
        case blue
        case black
        case orange
        case pink
    }
    
    let category: Category
    let size: Size
    let color: Color
    let name: String
    let status: Status
}

extension Dress: Codable { }
