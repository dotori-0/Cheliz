//
//  BackupAndRestoreButton.swift
//  Cheliz
//
//  Created by SC on 2022/09/26.
//

import UIKit

final class BackupAndRestoreButton: UIButton {
    // MARK: - Properties
    var title: String?

    // MARK: - Initializers
    init(title: String) {
        self.title = title
        super.init(frame: .zero)
        
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Design Methods
    private func setUI() {
        guard let title = title else {
            print("No title for BackupAndRestoreButton")
            return
        }

        var container = AttributeContainer()
//        container.font = .meringue(size: 15)
        container.font = FontManager.preferredFont(ofSize: 15)
        container.foregroundColor = .label
        
        var buttonConfiguration = UIButton.Configuration.filled()
        buttonConfiguration.baseBackgroundColor = .systemBackground//.withAlphaComponent(0.5)
//        configuration.title = title
        buttonConfiguration.attributedTitle = AttributedString(title, attributes: container)
        
        configuration = buttonConfiguration
        
        addShadows()
    }
    
    private func addShadows() {
        addShadow(radius: 12, opacity: 0.2)
    }
}
