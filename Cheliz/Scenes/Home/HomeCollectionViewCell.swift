//
//  HomeCollectionViewCell.swift
//  Cheliz
//
//  Created by SC on 2022/09/12.
//

import UIKit

class HomeCollectionViewCell: BaseCollectionViewCell {
    // MARK: - Properties
    lazy var checkButton = UIButton().then {
        var configuration = UIButton.Configuration.plain()
//        configuration.image = UIImage(systemName: "circle")
        configuration.image = UIImage(systemName: "circle",
                                      withConfiguration: UIImage.SymbolConfiguration(pointSize: 18))
//        configuration.imagePadding = 0
//        configuration.contentInsets = .zero
//        let imgConfig = UIImage.SymbolConfiguration(pointSize: <#T##CGFloat#>)/
        $0.configuration = configuration
//        $0.backgroundColor = .systemRed
    }

    let posterImageView = UIImageView().then {
        $0.backgroundColor = .systemYellow
    }
    
    let titleLabel = UILabel().then {
//        label.font = UIFont.dongle(style: .Regular, size: 30)
//        label.font = .systemFont(ofSize: 20)
        $0.font = UIFont.hyemin(style: .Bold, size: 16)
//        $0.font = UIFont.barunpen(style: .Bold, size: 18)
    }
    
    let releaseYearLabel = UILabel().then {
//        $0.font = UIFont.dongle(style: .Regular, size: 12)
//        $0.font = .systemFont(ofSize: 20)
        $0.font = UIFont.hyemin(style: .Bold, size: 12)
//        $0.font = UIFont.barunpen(style: .Regular, size: 14)
    }
    
    lazy var stackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [titleLabel, releaseYearLabel])
        view.axis = .vertical
        view.alignment = .leading
        view.distribution = .fillEqually
//        view.spacing = 0
        return view
    }()
    
    let separatorView = UIView().then {
        $0.backgroundColor = .systemGray5  // .systemGray6?
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
        [checkButton, posterImageView, stackView, separatorView].forEach {
            contentView.addSubview($0)
        }
    }
    
    override func setConstraints() {
        checkButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(20)
            make.height.equalToSuperview().multipliedBy(0.4)
            make.width.equalTo(checkButton.snp.height)
        }
        
        posterImageView.snp.makeConstraints { make in
            make.leading.equalTo(checkButton.snp.trailing).offset(16)
            make.centerY.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.7)
            make.width.equalTo(posterImageView.snp.height).multipliedBy(0.67)
        }
        
        stackView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(posterImageView.snp.trailing).offset(12)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalToSuperview().multipliedBy(0.6)
        }
        
        separatorView.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.width.equalToSuperview()
            make.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
        }
    }
}
