//
//  SizeCalculatorViewModel.swift
//  sizecalculator
//
//  Created by Maxim Danilov on 7/18/19.
//  Copyright © 2019 ANODA. All rights reserved.
//

import Foundation

enum CalculatorError: LocalizedError {
    case invalidValue(MeasurementInputType, UnitLength)
    
    var errorDescription: String? {
        switch self {
        case .invalidValue(let type, let unit):
            return "\(type.rawValue) should be in range \(unit == .inches ? type.rangeInInches : type.rangeInCm)"
        }
    }
}

final class SizeCalculatorViewModel {
    var unit = UnitLength.centimeters
    
    var currentSize: Size?
    var currentCategory: Dress.Category = .evening
    
    private func validate(measurement: BodyMeasurement) throws {
        guard MeasurementInputType.validateValue(measurement.bust, for: .bust, in: unit) else {
            throw CalculatorError.invalidValue(.bust, unit)
        }
        guard MeasurementInputType.validateValue(measurement.hips, for: .hips, in: unit) else {
            throw CalculatorError.invalidValue(.hips, unit)
        }
        guard MeasurementInputType.validateValue(measurement.waist, for: .waist, in: unit) else {
            throw CalculatorError.invalidValue(.waist, unit)
        }
    }
    
    func calculateSize(for measurement: BodyMeasurement) throws -> Size {
        try validate(measurement: measurement)
        let convertedMeasurements = unit == .inches ? unit.convert(measurement: measurement, to: .centimeters) : measurement
        return size(for: convertedMeasurements)
    }
    
    private func size(for measurement: BodyMeasurement) -> Size {
        guard let bustIndex = Size.allCases.lastIndex(where: { $0.bust <= measurement.bust }) else { return .XXXS }
        guard let waistIndex = Size.allCases.lastIndex(where: { $0.waist <= measurement.waist }) else { return .XXXS }
        guard let hipsIndex = Size.allCases.lastIndex(where: { $0.hips <= measurement.hips }) else { return .XXXS }
        let bustSize = Size.allCases[bustIndex]
        let waistSize = Size.allCases[waistIndex]
        let hipsSize = Size.allCases[hipsIndex]
        
        return [bustSize, waistSize, hipsSize].max { $0.rawValue < $1.rawValue } ?? .XXXS
    }
}
