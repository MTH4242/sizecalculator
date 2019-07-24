//
//  SizeCalculatorVC.swift
//  sizecalculator
//
//  Created by Maxim Danilov on 7/18/19.
//  Copyright © 2019 ANODA. All rights reserved.
//

import UIKit

final class SizeCalculatorVC: UIViewController {
    
    private let contentView = SizeCalculatorView()
    private let viewModel = SizeCalculatorViewModel()
    
    override func loadView() {
        view = contentView
        contentView.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Size Calculator"
    }
}

extension SizeCalculatorVC: SizeCalculatorViewDelegate {
    func didSelectUnit(_ unit: UnitLength) {
        viewModel.unit = unit
    }
    
    func didTapCalculate() {
        contentView.endEditing(true)
        let measurement = BodyMeasurement(bust: contentView.bust, waist: contentView.waist, hips: contentView.hips)
        do {
            let size = try viewModel.calculateSize(for: measurement)
            contentView.updateResults(size: size)
        } catch {
            showErrorAlert(title: error.localizedDescription)
        }
    }
}
