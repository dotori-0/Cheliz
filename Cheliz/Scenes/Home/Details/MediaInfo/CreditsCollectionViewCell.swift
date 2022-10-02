//
//  CreditsCollectionViewCell.swift
//  Cheliz
//
//  Created by SC on 2022/09/30.
//

import UIKit

class CreditsCollectionViewCell: BaseCollectionViewCell {
    // MARK: - Properties
    let profileImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
//        $0.layer.cornerRadius = $0.bounds.width / 2
//        $0.layer.cornerRadius = $0.frame.width / 2
//        $0.layer.cornerRadius = 10
        $0.clipsToBounds = true
    }
    
    let nameLabel = CustomLabel(textSize: 14).then {
        $0.numberOfLines = 0
        $0.textAlignment = .center
        $0.sizeToFit()
    }
    
    let characterLabel = CustomLabel(textSize: 13.5, textColor: .secondaryLabel).then {
        $0.numberOfLines = 0
        $0.textAlignment = .center
        $0.sizeToFit()
    }
    
    let spacingBetweenProfileImageAndName: CGFloat = 4
    let spacingBetweenNameAndCharacter: CGFloat = 0
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        profileImageView.image = nil  // nil 처리를 할 경우 스크롤을 빨리 하면 이미지가 아예 안 나오는 건가.. . . .?
        nameLabel.text = nil
        characterLabel.text = nil
    }
    
    // MARK: - Design Methods
    override func setUI() {
//        print("🏝")
        
        [profileImageView, nameLabel, characterLabel].forEach {
            contentView.addSubview($0)
        }
        
//        backgroundColor = .systemPink
        profileImageView.backgroundColor = .systemMint
//        nameLabel.text = "이름 이름 이름 이름 이름 이름"
//        nameLabel.backgroundColor = .systemYellow
//        characterLabel.text = "배역 배역 배역 배역 배역 배역 배역"
//        characterLabel.backgroundColor = .systemGreen
        
        
        // 이미지 뷰 크기를 잡은 후 깎아야 하므로 async 처리
        DispatchQueue.main.async {
            self.profileImageView.layoutIfNeeded()  // 스크롤을 빨리 하면 이미지 모서리가 깎이지 않는 이슈 해결 코드
            self.profileImageView.layer.cornerRadius = self.profileImageView.frame.width / 2
        }
    }
    
    override func setConstraints() {
        profileImageView.snp.makeConstraints { make in
            make.top.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.9)
            make.height.equalTo(profileImageView.snp.width)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(profileImageView.snp.bottom).offset(spacingBetweenProfileImageAndName)
            make.leading.trailing.equalToSuperview()
        }
        
        characterLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(nameLabel.snp.bottom).offset(spacingBetweenNameAndCharacter)
            make.leading.trailing.equalToSuperview()
        }
    }
    
    // MARK: - Intenal Methods
    func showCreditInfo(of credit: Credit) {
        if let profilePath = credit.profilePath {
            let url = URL(string: Endpoint.imageConfigurationURL + profilePath)
            profileImageView.kf.setImage(with: url)
        }
        
        nameLabel.text = credit.name
        characterLabel.text = credit.character
    }
    
    func itemSizeFittedWithContents(name: String, character: String) -> CGSize {
        let screenWidth = UIScreen.main.bounds.width
        let itemWidth = screenWidth / 5
        let profileImageViewHeight = itemWidth * 0.9
        
        nameLabel.text = name
        characterLabel.text = character
        
        let itemHeight = profileImageViewHeight
                        + spacingBetweenProfileImageAndName
                        + nameLabel.frame.height
                        + spacingBetweenNameAndCharacter
                        + characterLabel.frame.height
        
//        let targetSize = CGSize(width: itemWidth, height: UIView.layoutFittingCompressedSize.height)
        let targetSize = CGSize(width: itemWidth, height: itemHeight)
        
        return self.contentView.systemLayoutSizeFitting(targetSize, withHorizontalFittingPriority: .required, verticalFittingPriority: .fittingSizeLevel)
    }
}
