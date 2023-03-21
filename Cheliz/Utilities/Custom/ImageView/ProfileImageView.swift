//
//  ProfileImageView.swift
//  Cheliz
//
//  Created by SC on 2022/10/04.
//

import UIKit

final class ProfileImageView: UIImageView {
    // MARK: - Properties
    var customBackgroundColor: UIColor?
    
    // MARK: - Initializers
    init(backgroundColor: UIColor) {
        self.customBackgroundColor = backgroundColor
        super.init(frame: .zero)
        
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Design Methods
    func setUI() {
        round(clipsToBounds: true)
         
        guard let customBackgroundColor = customBackgroundColor else {
            return
        }

        backgroundColor = customBackgroundColor
    }
}
