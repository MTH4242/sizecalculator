//
//  BodyMeasurement.swift
//  sizecalculator
//
//  Created by Maxim Danilov on 7/18/19.
//  Copyright © 2019 ANODA. All rights reserved.
//

import Foundation

struct BodyMeasurement {
    var bust: Double
    var waist: Double
    var hips: Double
}

extension UnitLength {
    func convert(measurement: BodyMeasurement, to unit: UnitLength) -> BodyMeasurement {
        let bust = Measurement(value: measurement.bust, unit: self).converted(to: unit).value
        let waist = Measurement(value: measurement.waist, unit: self).converted(to: unit).value
        let hips = Measurement(value: measurement.hips, unit: self).converted(to: unit).value
        return BodyMeasurement(bust: bust, waist: waist, hips: hips)
    }
}
