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
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "View Cart", style: .plain, handler: {
            
        })
    }
}

extension SizeCalculatorVC: SizeCalculatorViewDelegate {
    func didTapShowUsers() {
        let savedUsersVC = SavedUsersVC()
        savedUsersVC.delegate = self
        present(UINavigationController(rootViewController: savedUsersVC), animated: true)
    }
    
    func didTapSaveUsername() {
        guard let size = viewModel.currentSize else {
            showErrorAlert(title: "There is no size to save")
            return
        }
        guard let username = contentView.usernameTextField.text else {
            showErrorAlert(title: "Username is empty")
            return
        }
        let defaults = UserDefaults.standard
        guard var sizes = defaults.dictionary(forKey: "sizes") else {
            let a = [username: size.rawValue]
            defaults.set(a, forKey: "sizes")
            defaults.synchronize()
            return
        }
        sizes[username] = size.rawValue
        defaults.set(sizes, forKey: "sizes")
        defaults.synchronize()
    }
    
    func didSelectUnit(_ unit: UnitLength) {
        viewModel.unit = unit
    }
    
    func didTapCalculate() {
        contentView.endEditing(true)
        let measurement = BodyMeasurement(bust: contentView.bust, waist: contentView.waist, hips: contentView.hips)
        do {
            let size = try viewModel.calculateSize(for: measurement)
            viewModel.currentSize = size
            contentView.updateResults(size: size)
        } catch {
            showErrorAlert(title: error.localizedDescription)
        }
    }
    
    func didTapShowAvailableDresses() {
        guard let size = viewModel.currentSize else { return }
        let category = viewModel.currentCategory
        navigationController?.pushViewController(AvailableDressesVC(size: size, category: category), animated: true)
    }
    
    func didChangeCategory(_ category: Dress.Category) {
        viewModel.currentCategory = category
    }
}

extension SizeCalculatorVC: SavedUsersVCDelegate {
    func savedUsersVC(_ controller: SavedUsersVC, didSelectSavedSize size: (username: String, size: Size)) {
        contentView.bustTextField.text = "\(size.size.bust)"
        contentView.waistTextField.text = "\(size.size.waist)"
        contentView.hipTextField.text = "\(size.size.hips)"
        contentView.usernameTextField.text = "\(size.username)"
        contentView.textView.text = ""
    }
}
