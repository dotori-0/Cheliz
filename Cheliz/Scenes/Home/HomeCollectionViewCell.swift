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
    
    let checkButton = MediaPassableButton()//.then {
//        var configuration = UIButton.Configuration.plain()
//        configuration.image = UIImage(systemName: "circle",
//                                      withConfiguration: UIImage.SymbolConfiguration(pointSize: 18))
//        configuration.imagePadding = 0
//        configuration.contentInsets = .zero
//        let imgConfig = UIImage.SymbolConfiguration(pointSize: <#T##CGFloat#>)/
//        $0.configuration = configuration
//        $0.backgroundColor = .systemRed
//    }
    
    var buttonConfiguration: UIButton.Configuration = {
        var configuration = UIButton.Configuration.plain()
        configuration.image = UIImage(systemName: SFSymbol.circle,
                                      withConfiguration: UIImage.SymbolConfiguration(pointSize: 18))
//        configuration.baseBackgroundColor = UIColor.tintColor.withAlphaComponent(0.5)
//        configuration.baseForegroundColor = UIColor.tintColor.withAlphaComponent(0.5)
        return configuration
    }()

    let posterImageView = PosterImageView().then {
        $0.backgroundColor = .tintColor.withAlphaComponent(0.5)
    }
    
    let titleLabel = UILabel().then {
//        label.font = .systemFont(ofSize: 20)
//        label.font = UIFont.dongle(style: .Regular, size: 30)
        
//        $0.font = UIFont.hyemin(style: .Bold, size: 16)  // == meringue 19  == barunpen 18.5
//        $0.font = UIFont.hyemin(style: .Regular, size: 16)  // == meringue 19
        
//        $0.font = UIFont.barunpen(style: .Bold, size: 18.5)
//        $0.font = UIFont.barunpen(style: .Regular, size: 18.5)
        
        $0.font = UIFont.meringue(size: 18)
    }
    
    let releaseYearLabel = UILabel().then {
//        $0.font = .systemFont(ofSize: 20)
//        $0.font = UIFont.dongle(style: .Regular, size: 12)
        
//        $0.font = UIFont.hyemin(style: .Bold, size: 12)  // == meringue 14
//        $0.font = UIFont.hyemin(style: .Regular, size: 12)  // == meringue 14
        
//        $0.font = UIFont.barunpen(style: .Bold, size: 14)
//        $0.font = UIFont.barunpen(style: .Regular, size: 14)
        
        $0.font = UIFont.meringue(size: 14)
        $0.textColor = .systemGray
    }
    
    let mediaTypeLabel = UILabel().then {
//        $0.font = .systemFont(ofSize: 20)
        
//        $0.font = UIFont.hyemin(style: .Bold, size: 12)
//        $0.font = UIFont.hyemin(style: .Regular, size: 12)
        
//        $0.font = UIFont.barunpen(style: .Bold, size: 14)
//        $0.font = UIFont.barunpen(style: .Regular, size: 14)
        
        $0.font = UIFont.meringue(size: 14)
        $0.textColor = .systemGray
    }
    
    lazy var stackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [titleLabel, releaseYearLabel, mediaTypeLabel])
        view.axis = .vertical
        view.alignment = .leading
        view.distribution = .fillEqually
//        view.spacing = 0
//        view.backgroundColor = .systemGreen
        return view
    }()
    
    let separatorView = UIView().then {
//        $0.backgroundColor = .systemGray5  // .systemGray6?
        $0.backgroundColor = .clear  // .systemGray6?
    }
    

    // MARK: - Initializers
    override func prepareForReuse() {
        super.prepareForReuse()
        
        posterImageView.image = nil
        // 👻 다른 것들도 nil 처리를 해야 할지?
    }
    
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
//        contentView.backgroundColor = .systemYellow  // 동작 O
//        backgroundColor = .systemMint  // 동작 O
//        backgroundColor = .systemGroupedBackground.withAlphaComponent(0.5)
//        backgroundColor = .systemGroupedBackground
        backgroundColor = .secondarySystemGroupedBackground.withAlphaComponent(0.4)  // 이걸로!
//        backgroundColor = .tertiarySystemGroupedBackground
        
//        superview?.layer.shadowColor = UIColor.black.cgColor
//        superview?.layer.shadowOffset = .zero
//        superview?.layer.shadowRadius = 10
//        superview?.layer.shadowOpacity = 0.7
        
    }
    
    override func setConstraints() {
//        checkButton.backgroundColor = .systemMint

        checkButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
//            make.leading.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(8)
//            make.height.equalToSuperview().multipliedBy(0.4)
//            make.width.equalTo(checkButton.snp.height)
            make.width.equalToSuperview().multipliedBy(0.1)
            make.height.equalTo(checkButton.snp.width)
        }
        checkButton.setContentCompressionResistancePriority(.required, for: .horizontal)
//        checkButton.setContentHuggingPriority(.required, for: .horizontal)

        posterImageView.snp.makeConstraints { make in
//            make.leading.equalTo(checkButton.snp.trailing).offset(16)
            make.leading.equalTo(checkButton.snp.trailing).offset(8)
            make.centerY.equalToSuperview()
//            make.height.equalToSuperview().multipliedBy(0.8)

            let screenHeight = UIScreen.main.bounds.height
            let imageHeight = screenHeight * 0.12
            make.height.equalTo(imageHeight)
            make.height.equalToSuperview().multipliedBy(0.9)
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
        
//        print("🍒", UIScreen.main.bounds.width)
//        // SE, 8, X: 375
//        // 13 Pro Max: 428
//
//        checkButton.backgroundColor = .systemMint
//
//        checkButton.snp.makeConstraints { make in
//            make.centerY.equalToSuperview()
////            make.leading.equalToSuperview().offset(16)
//            make.leading.equalToSuperview().offset(8)
//            make.height.equalToSuperview().multipliedBy(0.4)
//            make.width.equalTo(checkButton.snp.height)
//        }
//        checkButton.setContentCompressionResistancePriority(.required, for: .horizontal)
////        checkButton.setContentHuggingPriority(.required, for: .horizontal)
//
//
//        stackView.snp.makeConstraints { make in
//            make.centerY.equalToSuperview()
////            make.leading.equalTo(posterImageView.snp.trailing).offset(12)
//            make.width.equalToSuperview().multipliedBy(0.55)
//            make.trailing.equalToSuperview().offset(-20)
//            make.height.equalToSuperview().multipliedBy(0.65)
//        }
//
//        posterImageView.snp.makeConstraints { make in
//            make.leading.equalTo(checkButton.snp.trailing).offset(8)
//            make.trailing.equalTo(stackView.snp.leading).offset(-12)
//            make.centerY.equalToSuperview()
//            make.height.equalTo(posterImageView.snp.width).multipliedBy(1.414)
//
////            let screenHeight = UIScreen.main.bounds.height
////            let imageHeight = screenHeight * 0.12
////            make.height.equalTo(imageHeight)
////            make.width.equalTo(posterImageView.snp.height).multipliedBy(0.67)
//        }
//
//        separatorView.snp.makeConstraints { make in
//            make.height.equalTo(1)
//            make.width.equalToSuperview()
//            make.bottom.equalToSuperview()
//            make.centerX.equalToSuperview()
//        }
    }
    
    func setCheckButtonImage(watched: Bool) {
        let imageName = watched ? SFSymbol.checkmark : SFSymbol.circle
        buttonConfiguration.image = UIImage(systemName: imageName,
                                      withConfiguration: UIImage.SymbolConfiguration(pointSize: 18))
        checkButton.configuration = buttonConfiguration
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
        mediaTypeLabel.text = MediaType(rawValue: media.mediaType)?.string  // 👻 gaurd-let 처리
    }
}
