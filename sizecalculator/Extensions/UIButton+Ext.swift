//
//  UIButton+Ext.swift
//  sizecalculator
//
//  Created by Maxim Danilov on 7/18/19.
//  Copyright © 2019 ANODA. All rights reserved.
//

import UIKit

extension UIButton {
    
    static var selectionStyled: UIButton {
        let button = UIButton()
        button.clipsToBounds = true
        button.layer.cornerRadius = 10
        let bgImage = UIImage.image(from: UIColor.green.withAlphaComponent(0.6))
        button.setBackgroundImage(bgImage, for: .selected)
        button.setBackgroundImage(bgImage, for: .highlighted)
        button.setTitleColor(.black, for: .normal)
        button.setTitleColor(.white, for: .selected)
        return button
    }
}
