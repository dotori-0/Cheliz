//
//  SettingsTableViewCell.swift
//  Cheliz
//
//  Created by SC on 2022/09/25.
//

import UIKit

class SettingsTableViewCell: BaseTableViewCell {
    // MARK: - Properties
    let symbolImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
    }
    let titleLabel = UILabel().then {
        $0.font = .meringue(size: 18)
    }
    
    // MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
//        setUI()
//        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Design Methods
    override func setUI() {
        [symbolImageView, titleLabel].forEach {
            contentView.addSubview($0)
        }
    }
    
    override func setConstraints() {
        symbolImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(20)
            make.height.equalToSuperview().multipliedBy(0.5)
            make.width.equalTo(symbolImageView.snp.height)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(symbolImageView.snp.trailing).offset(20)
            make.trailing.lessThanOrEqualTo(contentView.snp.trailing).offset(-20)
        }
    }
    
    // MARK: - Internal Methods
    func configureCell(imageName: String, title: String) {
        symbolImageView.image = UIImage(systemName: imageName)
        titleLabel.text = title
    }
}
