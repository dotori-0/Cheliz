//
//  SearchCollectionViewCell.swift
//  Cheliz
//
//  Created by SC on 2022/09/14.
//

import UIKit
import Kingfisher

class SearchCollectionViewCell: BaseCollectionViewCell {
    // MARK: - Properties
    let posterImageView = UIImageView().then {
        $0.backgroundColor = .systemYellow
    }
    
    let titleLabel = UILabel().then {
        $0.font = UIFont.hyemin(style: .Bold, size: 16)
//        $0.backgroundColor = .systemYellow
    }
    
    let releaseYearLabel = UILabel().then {
        $0.font = UIFont.hyemin(style: .Bold, size: 12)
//        $0.backgroundColor = .systemMint
        $0.textColor = .systemGray
    }
    
    let mediaTypeLabel = UILabel().then {
        $0.font = UIFont.hyemin(style: .Regular, size: 12)
//        $0.backgroundColor = .systemIndigo
        $0.textColor = .systemGray
    }
    
    lazy var stackView = UIStackView(arrangedSubviews: [titleLabel, releaseYearLabel, mediaTypeLabel]).then {
        $0.axis = .vertical
        $0.alignment = .leading
        $0.distribution = .fillEqually
    }
    
    let plusButton = UIButton().then {
        var configuration = UIButton.Configuration.plain()
//        configuration.image = UIImage(systemName: "text.badge.plus")
        configuration.image = UIImage(systemName: "text.badge.plus",
                                      withConfiguration: UIImage.SymbolConfiguration(pointSize: 18))
        $0.configuration = configuration
    }
    
    
    let separatorView = UIView().then {
        $0.backgroundColor = .systemGray3
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
        [plusButton, posterImageView, stackView, plusButton, separatorView].forEach {
            contentView.addSubview($0)
        }
    }
    
    override func setConstraints() {
        posterImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.centerY.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.8)
            make.width.equalTo(posterImageView.snp.height).multipliedBy(0.67)
        }
        
        plusButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalToSuperview().multipliedBy(0.4)
            make.width.equalTo(plusButton.snp.height)
        }
        
        stackView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(posterImageView.snp.trailing).offset(12)
            make.trailing.equalTo(plusButton.snp.leading).offset(-20)
            make.height.equalToSuperview().multipliedBy(0.6)
        }
        
        separatorView.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.width.equalToSuperview()
            make.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
        }
    }
    
    // MARK: - Internal Methods
    func showResult(with media: MediaModel) {
        titleLabel.text = media.title
        releaseYearLabel.text = media.releaseDate
        mediaTypeLabel.text = media.mediaType.rawValue
        
        let url = URL(string: Endpoint.imageConfigurationURL + media.posterPath)
        posterImageView.kf.setImage(with: url)
    }
}
