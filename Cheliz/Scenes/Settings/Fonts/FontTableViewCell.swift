//
//  FontTableViewCell.swift
//  Cheliz
//
//  Created by SC on 2022/10/03.
//

import UIKit

class FontTableViewCell: BaseTableViewCell {
    // MARK: - Properties
    let button = SingleSelectionButton()
    let fontLabel = CustomLabel(textSize: 15)
    
    // MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Design Methods
    override func setUI() {
        [button, fontLabel].forEach {
            contentView.addSubview($0)
        }
        backgroundColor = .secondarySystemGroupedBackground.withAlphaComponent(0.5)
    }
    
    override func setConstraints() {
        button.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(18)
            make.width.equalToSuperview().multipliedBy(0.1)
            make.height.equalTo(button.snp.width)
        }
        
        fontLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(button.snp.trailing).offset(4)
            make.trailing.equalToSuperview().offset(-24)
        }
    }
}
