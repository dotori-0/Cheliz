//
//  SearchCollectionViewCell.swift
//  Cheliz
//
//  Created by SC on 2022/09/14.
//

import UIKit
import Kingfisher

final class SearchCollectionViewCell: BaseCollectionViewCell {
    // MARK: - Properties
    let posterView = PosterView()
  
    let titleLabel = CustomLabel(textSize: 17)
    
    let releaseYearLabel = CustomLabel(textSize: 14)
  
    let mediaTypeLabel = CustomLabel(textSize: 14, textColor: .systemGray)
    
    lazy var stackView = UIStackView(arrangedSubviews: [titleLabel, releaseYearLabel, mediaTypeLabel]).then {
        $0.axis = .vertical
        $0.alignment = .leading
        $0.distribution = .fillEqually
    }
    
    let addButton = MediaPassableButton().then {
        var configuration = UIButton.Configuration.plain()
        configuration.image = UIImage(systemName: SFSymbol.addToList,
                                      withConfiguration: UIImage.SymbolConfiguration(pointSize: 18))
        $0.configuration = configuration
    }
    
    let separatorView = UIView().then {
        $0.backgroundColor = .systemGray3
    }
    
    // MARK: - Initializers
    override func prepareForReuse() {
        super.prepareForReuse()
        
        posterView.posterImageView.image = nil
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
//        setAddButtonAction()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Design Methods
    override func setUI() {
        [addButton, posterView, stackView, addButton, separatorView].forEach {
            contentView.addSubview($0)
        }
        
        backgroundColor = .secondarySystemGroupedBackground.withAlphaComponent(0.4)
    }
    
    override func setConstraints() {
        posterView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(20)
            make.centerY.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.8)
            make.width.equalTo(posterView.snp.height).multipliedBy(0.67)
        }
        
        addButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-20)
            make.height.equalToSuperview().multipliedBy(0.4)
            make.width.equalTo(addButton.snp.height)
        }
        
        stackView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(posterView.snp.trailing).offset(12)
            make.trailing.equalTo(addButton.snp.leading).offset(-20)
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
    func showResult(of media: Media) {
//    func showResult(errorHandler: @escaping () -> Void) {
//        guard let media = media else {
//            errorHandler()
//            print("결과를 찾을 수 없습니다.")
//            return
//        }
        
        if let posterPath = media.posterPath {
            let url = URL(string: Endpoint.imageConfigurationURL + posterPath)
            posterView.posterImageView.kf.setImage(with: url)
//            posterImageView.kf.setImage(with: url)
        }

        titleLabel.text = media.title
        releaseYearLabel.text = media.releaseDate
        mediaTypeLabel.text = MediaType(rawValue: media.mediaType)?.string  // 👻 gaurd-let 처리
    }
    
    // MARK: - Action Methods
//    private func setAddButtonAction() {
//        addButton.addTarget(self, action: #selector(addButtonClicked), for: .touchUpInside)
//    }
//
//    @objc private func addButtonClicked() {
//        if let media = media, let addErrorHandler = addErrorHandler, let addCompletionHandler = addCompletionHandler {
//            let repository = MediaRepository()
//            repository.add(media: media, completionHandler: addCompletionHandler, errorHandler: addErrorHandler)
//        }
//    }
}
