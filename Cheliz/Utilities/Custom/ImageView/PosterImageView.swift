//
//  PosterImageView.swift
//  Cheliz
//
//  Created by SC on 2022/09/25.
//

import UIKit

final class PosterImageView: UIImageView {
    // MARK: - Properties
    var customBackgroundColor: UIColor?
    
    // MARK: - Initializers
//    override init(frame: CGRect = .zero) {  // 👻 초기값 없어도?
//        super.init(frame: frame)
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
//        contentMode = .scaleAspectFill
//        layer.cornerRadius = 10
//        clipsToBounds = true
        round(clipsToBounds: true)
         
        guard let customBackgroundColor = customBackgroundColor else {
            return
        }

        backgroundColor = customBackgroundColor
        
//        backgroundColor = .tintColor.withAlphaComponent(0.1)
//        image = .paleIcon
    }
}
