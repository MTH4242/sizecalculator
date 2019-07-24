//
//  Size.swift
//  sizecalculator
//
//  Created by Maxim Danilov on 7/18/19.
//  Copyright © 2019 ANODA. All rights reserved.
//

import Foundation

enum Size: Int, CaseIterable {
    case XXXS
    case XXS
    case XS
    case S
    case M
    case L
    case XL
    case XXL
    case XXXL
    case XXXXL
    case XXXXXL
    case XXXXXXL
    case XXXXXXXL
    case XXXXXXXXL
    
    var bust: Double {
        switch self {
        case .XXXS:
            return 77
        case .XXS:
            return 81
        case .XS:
            return 85
        case .S:
            return 89
        case .M:
            return 93
        case .L:
            return 98
        case .XL:
            return 103
        case .XXL:
            return 109
        case .XXXL:
            return 116
        case .XXXXL:
            return 122
        case .XXXXXL:
            return 128
        case .XXXXXXL:
            return 134
        case .XXXXXXXL:
            return 140
        case .XXXXXXXXL:
            return 146
        }
    }
    
    var waist: Double {
        switch self {
        case .XXXS:
            return 56
        case .XXS:
            return 60
        case .XS:
            return 64
        case .S:
            return 68
        case .M:
            return 72
        case .L:
            return 76
        case .XL:
            return 83
        case .XXL:
            return 90
        case .XXXL:
            return 96
        case .XXXXL:
            return 103
        case .XXXXXL:
            return 110
        case .XXXXXXL:
            return 117
        case .XXXXXXXL:
            return 123
        case .XXXXXXXXL:
            return 131
        }
    }
    
    var hips: Double {
        switch self {
        case .XXXS:
            return 84
        case .XXS:
            return 88
        case .XS:
            return 92
        case .S:
            return 96
        case .M:
            return 100
        case .L:
            return 104
        case .XL:
            return 110
        case .XXL:
            return 116
        case .XXXL:
            return 123
        case .XXXXL:
            return 129
        case .XXXXXL:
            return 135
        case .XXXXXXL:
            return 142
        case .XXXXXXXL:
            return 148
        case .XXXXXXXXL:
            return 154
        }
    }
    
    var UK: Int {
        switch self {
        case .XXXS:
            return 4
        case .XXS:
            return 6
        case .XS:
            return 8
        case .S:
            return 10
        case .M:
            return 12
        case .L:
            return 14
        case .XL:
            return 16
        case .XXL:
            return 18
        case .XXXL:
            return 20
        case .XXXXL:
            return 22
        case .XXXXXL:
            return 24
        case .XXXXXXL:
            return 26
        case .XXXXXXXL:
            return 28
        case .XXXXXXXXL:
            return 30
        }
    }
    
    var EU: Int {
        switch self {
        case .XXXS:
            return 30
        case .XXS:
            return 32
        case .XS:
            return 34
        case .S:
            return 36
        case .M:
            return 38
        case .L:
            return 40
        case .XL:
            return 42
        case .XXL:
            return 44
        case .XXXL:
            return 46
        case .XXXXL:
            return 48
        case .XXXXXL:
            return 50
        case .XXXXXXL:
            return 52
        case .XXXXXXXL:
            return 54
        case .XXXXXXXXL:
            return 56
        }
    }
    
    var US: Int {
        switch self {
        case .XXXS:
            return 2
        case .XXS:
            return 4
        case .XS:
            return 6
        case .S:
            return 8
        case .M:
            return 10
        case .L:
            return 12
        case .XL:
            return 14
        case .XXL:
            return 16
        case .XXXL:
            return 18
        case .XXXXL:
            return 20
        case .XXXXXL:
            return 22
        case .XXXXXXL:
            return 24
        case .XXXXXXXL:
            return 26
        case .XXXXXXXXL:
            return 28
        }
    }
    
    var name: String {
        switch self {
        case .XXXS:
            return "XXXS"
        case .XXS:
            return "XXS"
        case .XS:
            return "XS"
        case .S:
            return "S"
        case .M:
            return "M"
        case .L:
            return "L"
        case .XL:
            return "XL"
        case .XXL:
            return "2XL"
        case .XXXL:
            return "3XL"
        case .XXXXL:
            return "4XL"
        case .XXXXXL:
            return "5XL"
        case .XXXXXXL:
            return "6XL"
        case .XXXXXXXL:
            return "7XL"
        case .XXXXXXXXL:
            return "8XL"
        }
    }
}
