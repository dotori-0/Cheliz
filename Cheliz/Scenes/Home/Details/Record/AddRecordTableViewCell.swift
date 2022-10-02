//
//  AddRecordTableViewCell.swift
//  Cheliz
//
//  Created by SC on 2022/10/02.
//

import UIKit

class AddRecordTableViewCell: BaseTableViewCell {
    // MARK: - Properties
    let addButton = MediaPassableButton()
    let buttonConfiguration: UIButton.Configuration = {
        var configuration = UIButton.Configuration.filled()
        configuration.image = UIImage(systemName: SFSymbol.plus,
                                      withConfiguration: UIImage.SymbolConfiguration(pointSize: 18))
//        configuration.baseBackgroundColor = UIColor.tintColor.withAlphaComponent(0.5)
//        configuration.baseBackgroundColor = .systemYellow
        configuration.baseBackgroundColor = .clear
        configuration.baseForegroundColor = UIColor.tintColor.withAlphaComponent(0.5)
//        configuration.baseForegroundColor = UIColor.tintColor
//        configuration.baseForegroundColor = .systemPink
        
        return configuration
    }()
    
    let addRecordLabel = CustomLabel(textSize: 15, textColor: .secondaryLabel).then {
        $0.text = Notice.addRecord
    }
    
    // MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Design Methods
    override func setUI() {
        [addButton, addRecordLabel].forEach {
            contentView.addSubview($0)
        }
        
        backgroundColor = .secondarySystemGroupedBackground.withAlphaComponent(0.5)

        setAddButton()
    }
    
    override func setConstraints() {
        addButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(18)
            make.width.equalToSuperview().multipliedBy(0.1)
            make.height.equalTo(addButton.snp.width)
        }
        
        addRecordLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(addButton.snp.trailing).offset(4)
            make.trailing.equalToSuperview().offset(-24)
        }
    }
    
    private func setAddButton() {
//        addButton.backgroundColor = .systemYellow
        addButton.configuration = buttonConfiguration
    }
}
