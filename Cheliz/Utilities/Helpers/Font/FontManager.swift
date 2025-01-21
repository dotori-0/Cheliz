//
//  FontManager.swift
//  Cheliz
//
//  Created by SC on 1/21/25.
//

import UIKit

enum FontManager {
    static var currentFont: AppFont {
        return AppFont(rawValue: UserDefaults.fontPreference) ?? .system
    }
    
    static func configureFont(to font: AppFont) {
        UserDefaults.fontPreference = font.rawValue
//        NotificationCenter.default.post(name: .font, object: <#T##Any?#>)
        NotificationCenter.default.post(name: .fontPreferedDidChange, object: nil)
    }
    
    static func preferredFont(ofSize: CGFloat) -> UIFont {
        let font: UIFont?
        
        switch currentFont {
            case .meringue:
                font =  UIFont(name: "BaMeringue", size: ofSize)
            case .system:
                font = UIFont.systemFont(ofSize: ofSize)
        }
        
        return font ?? UIFont.systemFont(ofSize: ofSize)
    }
}
