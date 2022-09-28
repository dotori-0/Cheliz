//
//  BackupFileTableViewCell.swift
//  Cheliz
//
//  Created by SC on 2022/09/26.
//

import UIKit

class BackupFileTableViewCell: BaseTableViewCell {
    // MARK: - Properties
    let fileSymbolImageView = UIImageView().then {
        $0.image = UIImage(systemName: SFSymbol.file)
        $0.contentMode = .scaleAspectFit
    }
    
    let fileNameLabel = CustomLabel(textSize: 15)
    
    let fileSizeLabel = CustomLabel(textSize: 14, textColor: .systemGray3)
    
    lazy var stackView = UIStackView(arrangedSubviews: [fileNameLabel, fileSizeLabel]).then {
        $0.axis = .vertical
        $0.alignment = .leading
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
        [fileSymbolImageView, stackView].forEach {
            contentView.addSubview($0)
        }
        
//        addShadow(radius: 12, opacity: 1)
//        backgroundColor = .clear  // tableView의 shadow가 사라짐...
//        contentView.backgroundColor = .clear
    }
    
    override func setConstraints() {
        fileSymbolImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.centerY.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.5)
            make.width.equalTo(fileSymbolImageView.snp.height)
        }
        
        stackView.snp.makeConstraints { make in
            make.leading.equalTo(fileSymbolImageView.snp.trailing).offset(12)
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalToSuperview().multipliedBy(0.6)
        }
    }
}
