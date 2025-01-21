//
//  CustomLabel.swift
//  Cheliz
//
//  Created by SC on 2022/09/29.
//

import UIKit

final class CustomLabel: UILabel {
    // MARK: - Initializers
    init(textSize: CGFloat, textColor: UIColor = .label) {
        super.init(frame: .zero)
        
        font = FontManager.preferredFont(ofSize: textSize)
        self.textColor = textColor
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
