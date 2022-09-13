//
//  HomeCollectionViewCell.swift
//  Cheliz
//
//  Created by SC on 2022/09/12.
//

import UIKit

class HomeCollectionViewCell: BaseCollectionViewCell {
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
//        configuration.image = UIImage(systemName: "checkmark.circle")
//        configuration.image = UIImage(systemName: <#T##String#>, withConfiguration: UIImage.SymbolConfiguration(pointSize: <#T##CGFloat#>, weight: <#T##UIImage.SymbolWeight#>, scale: <#T##UIImage.SymbolScale#>))
        configuration.image = UIImage(systemName: "circle",
                                      withConfiguration: UIImage.SymbolConfiguration(pointSize: 22))
//                                      withConfiguration: UIImage.SymbolConfiguration(pointSize: <#T##CGFloat#>, weight: <#T##UIImage.SymbolWeight#>, scale: <#T##UIImage.SymbolScale#>))
//        configuration.imagePadding = 0
//        configuration.contentInsets = .zero
//        let imgConfig = UIImage.SymbolConfiguration(pointSize: <#T##CGFloat#>)/
        $0.configuration = configuration
//        $0.backgroundColor = .systemRed
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
//        label.font = UIFont.dongle(style: .Regular, size: 30)
        label.font = UIFont.hyemin(style: .Bold, size: 20)
//        label.font = .systemFont(ofSize: 20)
        return label
    }()
    
    let releaseYearLabel: UILabel = {
        let label = UILabel()
//        label.font = UIFont.dongle(style: .Regular, size: 12)
//        label.font = .systemFont(ofSize: 20)
        label.font = UIFont.hyemin(style: .Bold, size: 12)
        return label
    }()
    
    lazy var stackView: UIStackView = {
        let view = UIStackView(arrangedSubviews: [titleLabel, releaseYearLabel])
        view.axis = .vertical
        view.alignment = .leading
        return view
    }()
    
    let separatorView = UIView().then {
        $0.backgroundColor = .systemGray2
    }
    

    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    override func setUI() {
        [checkButton, posterImageView, stackView, separatorView].forEach {
            contentView.addSubview($0)
        }
        contentView.backgroundColor = .systemMint
    }
    
    override func setConstraints() {
        checkButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(20)
            make.height.equalToSuperview().multipliedBy(0.4)
            make.width.equalTo(checkButton.snp.height)
        }
        
        posterImageView.snp.makeConstraints { make in
            make.leading.equalTo(checkButton.snp.trailing).offset(20)
            make.centerY.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.7)
            make.width.equalTo(posterImageView.snp.height).multipliedBy(0.67)
        }
        
        stackView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(posterImageView.snp.trailing).offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalToSuperview().multipliedBy(0.7)
        }
        
        separatorView.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.width.equalToSuperview()
            make.bottom.equalToSuperview()
            make.centerX.equalToSuperview()
        }
    }
}
