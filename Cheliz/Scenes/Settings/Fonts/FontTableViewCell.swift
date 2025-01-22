//
//  FontTableViewCell.swift
//  Cheliz
//
//  Created by SC on 2022/10/03.
//

import UIKit

final class FontTableViewCell: BaseTableViewCell {
    // MARK: - Properties
    private let fontLabel = UILabel()
    private let labelTextSize: CGFloat = 16
    
    // MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Design Methods
    override func setUI() {
        contentView.addSubview(fontLabel)
        backgroundColor = .secondarySystemGroupedBackground.withAlphaComponent(0.5)
    }
    
    override func setConstraints() {
        fontLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(24)
        }
    }
    
    // MARK: - Configurations
    func configure(with font: AppFont) {
        fontLabel.text = font.title
        configureEachFont(font)
        accessoryType = UserDefaults.fontPreference == font.rawValue ? .checkmark : .none
    }
    
    private func configureEachFont(_ font: AppFont) {
        let uiFont: UIFont?
        
        switch font {
            case .system:
                uiFont = UIFont.systemFont(ofSize: labelTextSize)
            case .meringue:
                uiFont = UIFont(name: "BaMeringue", size: labelTextSize)
        }
        
        fontLabel.font = uiFont
    }
}
