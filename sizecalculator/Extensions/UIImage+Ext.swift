//
//  UIImage+Ext.swift
//  sizecalculator
//
//  Created by Maxim Danilov on 7/18/19.
//  Copyright © 2019 ANODA. All rights reserved.
//

import UIKit

extension UIImage {
    static func image(from color: UIColor, size: CGSize? = nil) -> UIImage? {
        let format = UIGraphicsImageRendererFormat()
        format.scale = UIScreen.main.scale
        format.opaque = false
        
        let outputSize = size ?? CGSize(width: 1, height: 1)
        let renderer = UIGraphicsImageRenderer(size: outputSize, format: format)
        let image = renderer.image { context in
            color.setFill()
            let rect = CGRect(origin: .zero, size: outputSize)
            context.fill(rect)
        }
        return image
    }
}

