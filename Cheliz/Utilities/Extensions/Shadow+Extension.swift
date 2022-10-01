//
//  Shadow+Extension.swift
//  Cheliz
//
//  Created by SC on 2022/09/26.
//

import UIKit

extension UIView {
    func addShadow(radius: CGFloat, opacity: Float, shadowColor: CGColor = UIColor.tintColor.cgColor) {
        layer.shadowColor = shadowColor
        layer.shadowOffset = .zero
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity
    }
    
    func addShadowWithBezierPath(radius: CGFloat, opacity: Float, shadowColor: CGColor = UIColor.tintColor.cgColor) {
        layer.shadowColor = shadowColor
        layer.shadowOffset = .zero
//        layer.shadowOffset = CGSize(width: 0, height: -40)
        layer.shadowRadius = radius
        layer.shadowOpacity = opacity
//        layer.shadowPath = UIBezierPath(roundedRect: CGRect(x: 0,
//                                                            y: bounds.maxY - layer.shadowRadius,
//                                                            width: bounds.width,
//                                                            height: layer.shadowRadius),
//                                        byRoundingCorners: [.topLeft, .topRight],
//                                        cornerRadii: CGSize(width: radius, height: radius)).cgPath
        layer.shadowPath = UIBezierPath(rect: CGRect(x: 0,
                                                     y: bounds.minY,
                                                     width: bounds.width,
                                                     height: radius)).cgPath
        
    }
}
