//
//  Shadow+Extension.swift
//  Cheliz
//
//  Created by SC on 2022/09/26.
//

import UIKit

extension UIView {
    func addShadow(radius: CGFloat, opacity: Float) {
        layer.shadowColor = UIColor.tintColor.cgColor
        layer.shadowOffset = .zero
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity
    }
}
