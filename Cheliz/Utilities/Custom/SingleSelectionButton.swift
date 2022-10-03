//
//  SingleSelectionButton.swift
//  Cheliz
//
//  Created by SC on 2022/10/03.
//

import UIKit

class SingleSelectionButton: UIButton {
    // MARK: - Properties
    override var isSelected: Bool {
        didSet {
            setButtonImage(isSelected: isSelected)
        }
    }
    
    private var buttonConfiguration: UIButton.Configuration = {
        var configuration = UIButton.Configuration.plain()
        configuration.image = UIImage(systemName: SFSymbol.circle,
                                      withConfiguration: UIImage.SymbolConfiguration(pointSize: 18))
//        configuration.baseBackgroundColor = UIColor.tintColor.withAlphaComponent(0.5)
//        configuration.baseForegroundColor = UIColor.tintColor.withAlphaComponent(0.5)
        return configuration
    }()
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setting Methods
    func setButtonImage(isSelected: Bool) {
        let imageName = isSelected ? SFSymbol.circleInsetFilled : SFSymbol.circle
        buttonConfiguration.image = UIImage(systemName: imageName,
                                      withConfiguration: UIImage.SymbolConfiguration(pointSize: 18))
        buttonConfiguration.baseBackgroundColor = .clear
//        buttonConfiguration.baseForegroundColor = isSelected ? .tintColor.withAlphaComponent(0.5) : .lightGray
        buttonConfiguration.baseForegroundColor = isSelected ? .tintColor : .lightGray
        configuration = buttonConfiguration
    }
}
