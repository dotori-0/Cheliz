//
//  BackupAndRestoreView.swift
//  Cheliz
//
//  Created by SC on 2022/09/26.
//

import UIKit

class BackupAndRestoreView: BaseView {
    // MARK: - Properties
    let cloudImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
        $0.image = UIImage(systemName: SFSymbol.cloudFill)
        $0.tintColor = .white
//        $0.layer.shadowColor = UIColor.tintColor.cgColor
//        $0.layer.shadowOffset = .zero
//        $0.layer.shadowRadius = 60
//        $0.layer.shadowOpacity = 0.4
        $0.addShadow(radius: 60, opacity: 0.4)
    }
    
    let backupInfoLabel = UILabel().then {
        $0.text = Notice.backupAndRestoreInfo
        $0.font = .meringue(size: 13)
//        $0.font = .systemFont(ofSize: 13)
        $0.numberOfLines = 0
        $0.textAlignment = .left
        $0.textColor = .secondaryLabel
//        $0.backgroundColor = .systemMint
    }
    
    let backupFileLabel = UILabel().then {
        $0.text = Notice.backupFile
        $0.font = .meringue(size: 17)
    }
    
//    var buttonConfiguration: UIButton.Configuration = {
//        var configuration = UIButton.Configuration.plain()
//        configuration.baseBackgroundColor = .label.withAlphaComponent(0.5)
//        return configuration
//    }()
    
//    let backupButton = UIButton().then {
//        buttonConfiguration.title = Notice.backup
//        $0.configuration = buttonConfiguration
//    }
    
    let backupButton = BackupAndRestoreButton(title: Notice.backup)
    
    let importBackupFileButton = BackupAndRestoreButton(title: Notice.bring)
    
    lazy var buttonsStackView = UIStackView(arrangedSubviews: [backupButton, importBackupFileButton]).then {
        $0.axis = .horizontal
        $0.spacing = 20
        $0.alignment = .fill
        $0.distribution = .fillEqually  // 빼도 될지?
    }
    
    let tableView = UITableView(frame: .zero, style: .insetGrouped).then {
        $0.register(BackupFileTableViewCell.self, forCellReuseIdentifier: BackupFileTableViewCell.reuseIdentifier)
        $0.backgroundColor = .clear
//        $0.backgroundColor = .systemMint
        $0.addShadow(radius: 12, opacity: 0.2)
    }
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Design Methods
    override func setUI() {
        [cloudImageView, backupInfoLabel, backupFileLabel, buttonsStackView, tableView].forEach {
            addSubview($0)
        }
    }
    
    override func setConstraints() {
        cloudImageView.snp.makeConstraints { make in
//            make.top.equalToSuperview().offset(30)
            make.top.equalTo(safeAreaLayoutGuide).offset(30)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.35)
            make.height.equalTo(cloudImageView.snp.width)
        }
        
        backupInfoLabel.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.85)
            make.top.equalTo(cloudImageView.snp.bottom).offset(24)
            make.centerX.equalToSuperview()
        }
        
        backupFileLabel.snp.makeConstraints { make in
            make.top.equalTo(backupInfoLabel.snp.bottom).offset(24)
            make.leading.equalTo(backupInfoLabel.snp.leading)
        }
        
        buttonsStackView.snp.makeConstraints { make in
            make.top.equalTo(backupFileLabel.snp.bottom).offset(20)
            make.width.equalToSuperview().multipliedBy(0.75)
            make.height.equalTo(56)
            make.centerX.equalToSuperview()
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(buttonsStackView.snp.bottom).offset(24)
//            make.width.centerX.bottom.equalToSuperview()
            make.width.centerX.equalToSuperview()
            make.bottom.equalTo(safeAreaLayoutGuide)
        }
    }
}
