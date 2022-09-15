//
//  UIFont+Extension.swift
//  Cheliz
//
//  Created by SC on 2022/09/12.
//

import UIKit

extension UIFont {
    enum Style: String {
        case Light, Regular, Bold
    }
    
    static func dongle(style: Style, size: CGFloat) -> UIFont {
        return UIFont(name: "Dongle-\(style)", size: size)!
    }
    
    static func hyemin(style: Style, size: CGFloat) -> UIFont {
        return UIFont(name: "IMHyemin-\(style)", size: size)!
    }
    
    static func barunpen(style: Style, size: CGFloat) -> UIFont {
        let fontName = style == .Regular ? "NanumBarunpen" : "NanumBarunpen-\(style)"
        return UIFont(name: fontName, size: size)!
    }
}

//Dongle-Regular
//Dongle-Light
//Dongle-Bold

//IMHyemin-Regular
//IMHyemin-Bold

//NanumBarunpen
//NanumBarunpen-Bold
