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
        guard font != currentFont else { return }
        UserDefaults.fontPreference = font.rawValue
        NotificationCenter.default.post(name: .fontPreferenceDidChange, object: nil)
    }
    
    static func preferredFont(ofSize: CGFloat) -> UIFont {
        let font: UIFont?
        
        switch currentFont {
            case .system:
                font = UIFont.systemFont(ofSize: ofSize)
            case .meringue:
                font =  UIFont(name: "BaMeringue", size: ofSize)
        }
        
        return font ?? UIFont.systemFont(ofSize: ofSize)
    }
}
