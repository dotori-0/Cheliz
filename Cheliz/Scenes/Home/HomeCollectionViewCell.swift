//
//  HomeCollectionViewCell.swift
//  Cheliz
//
//  Created by SC on 2022/09/12.
//

import UIKit
import Kingfisher

class HomeCollectionViewCell: BaseCollectionViewCell {
    // MARK: - Properties
//    var media: Media?
    
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
        $0.textColor = .systemGray
    }
    
    let mediaTypeLabel = UILabel().then {
        $0.font = UIFont.hyemin(style: .Regular, size: 12)
        $0.textColor = .systemGray
    }
    
    lazy var stackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [titleLabel, releaseYearLabel, mediaTypeLabel])
        view.axis = .vertical
        view.alignment = .leading
        view.distribution = .fillEqually
//        view.spacing = 0
//        view.backgroundColor = .systemYellow
        return view
    }()
    
    let separatorView = UIView().then {
//        $0.backgroundColor = .systemGray5  // .systemGray6?
        $0.backgroundColor = .clear  // .systemGray6?
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
//            make.leading.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(8)
            make.height.equalToSuperview().multipliedBy(0.4)
            make.width.equalTo(checkButton.snp.height)
        }
        
        posterImageView.snp.makeConstraints { make in
//            make.leading.equalTo(checkButton.snp.trailing).offset(16)
            make.leading.equalTo(checkButton.snp.trailing).offset(8)
            make.centerY.equalToSuperview()
//            make.height.equalToSuperview().multipliedBy(0.8)
            
            let screenHeight = UIScreen.main.bounds.height
            let imageHeight = screenHeight * 0.12
            make.height.equalTo(imageHeight)
            make.width.equalTo(posterImageView.snp.height).multipliedBy(0.67)
        }
        
        stackView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(posterImageView.snp.trailing).offset(12)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalToSuperview().multipliedBy(0.65)
        }
        
        separatorView.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.width.equalToSuperview()
            make.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
        }
    }
    
    // MARK: - Internal Methods
//    func showSavedMedia() {
//        guard let media = media else {
//            return
//        }
//
//        if let posterPath = media.posterPath {
//            let url = URL(string: Endpoint.imageConfigurationURL + posterPath)
//            posterImageView.kf.setImage(with: url)
//        }
//
//        titleLabel.text = media.title
//        releaseYearLabel.text = media.releaseDate
//        mediaTypeLabel.text = media.mediaType
//    }
    
    func showSavedMedia(_ media: Media) {
        if let posterPath = media.posterPath {
            let url = URL(string: Endpoint.imageConfigurationURL + posterPath)
            posterImageView.kf.setImage(with: url)
        }
        
        titleLabel.text = media.title
        releaseYearLabel.text = media.releaseDate
        mediaTypeLabel.text = media.mediaType
    }
}
