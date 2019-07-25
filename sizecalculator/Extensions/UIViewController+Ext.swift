//
//  UIViewController+Ext.swift
//  sizecalculator
//
//  Created by Maxim Danilov on 7/18/19.
//  Copyright © 2019 ANODA. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func showErrorAlert(title: String) {
        if let childVC = presentedViewController, childVC is UIAlertController { return }
        let alert = UIAlertController(title: "Error", message: title, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(okButton)
        present(alert, animated: true)
    }
    
    func showAlert(title: String, message: String) {
        if let childVC = presentedViewController, childVC is UIAlertController { return }
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(okButton)
        present(alert, animated: true)
    }
}
