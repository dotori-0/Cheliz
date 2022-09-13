//
//  HomeTableViewCell.swift
//  Cheliz
//
//  Created by SC on 2022/09/12.
//

import UIKit

class HomeTableViewCell: BaseTableViewCell {
    // MARK: - Properties
//    let checkButton: UIButton = {
//        let button = UIButton()
//        var configuration = UIButton.Configuration.plain()
//        configuration.image = UIImage(systemName: "checkmark.circle")
//        button.configuration = configuration
//        return button
//    }()
    let checkButton = UIButton().then {
        var configuration = UIButton.Configuration.plain()
        configuration.image = UIImage(systemName: "checkmark.circle")
        $0.configuration = configuration
    }
    
    let label = UILabel().then {
      $0.textAlignment = .center
      $0.textColor = .black
      $0.text = "Hello, World!"
    }
    
    let posterImageView: UIImageView = {
        let view = UIImageView()
        view.backgroundColor = .systemYellow
        return view
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.dongle(style: .Bold, size: 20)
        return label
    }()
    
    let releaseYearLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.dongle(style: .Regular, size: 12)
        return label
    }()
    

    // MARK: - Functions
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setUI() {
        [checkButton, posterImageView, titleLabel, releaseYearLabel].forEach {
            contentView.addSubview($0)
        }
    }
    
    override func setConstraints() {
        checkButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(20)
            make.height.equalToSuperview().multipliedBy(0.5)
            make.width.equalTo(checkButton.snp.height)
        }
        
        posterImageView.snp.makeConstraints { make in
            make.leading.equalTo(checkButton.snp.trailing).offset(20)
            make.centerY.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.7)
            make.width.equalTo(posterImageView.snp.height).multipliedBy(2 / 3)
        }
    }
}
