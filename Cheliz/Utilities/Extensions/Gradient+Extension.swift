//
//  Gradient+Extension.swift
//  Cheliz
//
//  Created by SC on 2022/09/29.
//

import UIKit

extension UIView {
    func setGradient() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        
        let colors: [CGColor] = [
           .init(red: 0, green: 0.9810667634, blue: 0.5736914277, alpha: 1),
           .init(red: 0.5563425422, green: 0.9793455005, blue: 0, alpha: 1),
           .init(red: 0.9994240403, green: 0.9855536819, blue: 0, alpha: 1)
        ]
        
        gradientLayer.colors = colors
//        gradientLayer.colors = [UIColor.systemPink.cgColor, UIColor.clear.cgColor]
//        gradientLayer.locations = [0.0, 1.0]
//        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
//        gradientLayer.endPoint = CGPoint(x: 0, y: 1)

        self.layer.addSublayer(gradientLayer)
//        layer.insertSublayer(gradientLayer, at: 0)
    }
}
