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
        
        addObserver()   // 폰트 변경 알림 수신
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        removeObserver()
    }
    
    // MARK: - Observer
    private func addObserver() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(updateFont),
            name: .fontPreferenceDidChange,
            object: nil)
    }
    
    private func removeObserver() {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Font
    @objc private func updateFont() {
        font = FontManager.preferredFont(ofSize: font.pointSize)
    }
}
