//
//  MeasurementInputType.swift
//  sizecalculator
//
//  Created by Maxim Danilov on 7/18/19.
//  Copyright © 2019 ANODA. All rights reserved.
//

import Foundation

enum MeasurementInputType: String {
    case bust = "Bust"
    case waist = "Waist"
    case hips = "Hips"
    
    var rangeInCm: ClosedRange<Double> {
        switch self {
        case .bust:
            return 77...146
        case .waist:
            return 56...131
        case .hips:
            return 84...154
        }
    }
    
    var rangeInInches: ClosedRange<Double> {
        let min = Measurement(value: rangeInCm.lowerBound, unit: UnitLength.centimeters).converted(to: .inches).value
        let max = Measurement(value: rangeInCm.upperBound, unit: UnitLength.centimeters).converted(to: .inches).value
        return min...max
    }
    
    static func validateValue(_ value: Double, for input: MeasurementInputType, in unit: UnitLength) -> Bool {
        return unit == .inches ? input.rangeInInches.contains(value) : input.rangeInCm.contains(value)
    }
}
