//
//  MediaInfoHeaderView.swift
//  Cheliz
//
//  Created by SC on 2022/09/29.
//

import UIKit

class MediaInfoHeaderView: BaseView {
    // MARK: - Properties
    let backdropImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
    }
    
    let infoContainerView = UIView().then {
        $0.backgroundColor = .systemBackground
    }
    
    let posterImageView = PosterImageView()
    
    let titleLabel = CustomLabel(textSize: 18)
    
    let releaseDateAndRuntimeLabel = CustomLabel(textSize: 16, textColor: .quaternaryLabel)
    
    let genresLabel = CustomLabel(textSize: 16, textColor: .quaternaryLabel)
    
    let overviewLabel = CustomLabel(textSize: 15, textColor: .secondaryLabel).then {
        $0.numberOfLines = 0
    }
    
    
    // MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Design Methods
    override func setUI() {
        titleLabel.text = "타이틀"
        titleLabel.backgroundColor = .systemYellow
        
        releaseDateAndRuntimeLabel.text = "개봉일 + 런타임"
        releaseDateAndRuntimeLabel.backgroundColor = .systemGreen
        
        genresLabel.text = "장르 장르"
        genresLabel.backgroundColor = .systemOrange
        
        overviewLabel.text = "최고의 파일럿이자 전설적인 인물 매버릭은 자신이 졸업한 훈련학교 교관으로 발탁된다. 그의 명성을 모르던 팀원들은 매버릭의 지시를 무시하지만 실전을 방불케 하는 상공 훈련에서 눈으로 봐도 믿기 힘든 전설적인 조종 실력에 모두가 압도된다. 매버릭의 지휘 아래 견고한 팀워크를 쌓아가던 팀원들에게 국경을 뛰어넘는 위험한 임무가 주어지자 매버릭은 자신이 가르친 동료들과 함께 마지막이 될지 모를 하늘 위 비행에 나서는데..."
        overviewLabel.backgroundColor = .systemIndigo
        
        
        infoContainerView.layer.cornerRadius = 30
        infoContainerView.backgroundColor = .systemGray3
        
        backdropImageView.backgroundColor = .systemPink
        
        [posterImageView, titleLabel, releaseDateAndRuntimeLabel, genresLabel, overviewLabel].forEach {
            infoContainerView.addSubview($0)
        }
        
        [backdropImageView, infoContainerView].forEach {
            addSubview($0)
        }
    }
    
    override func setConstraints() {
        setConstraintsOfSubviewsOfInfoContainerView()
        setConstraintsOfBackdropImageViewAndInfoContainerView()
    }
    
    private func setConstraintsOfSubviewsOfInfoContainerView() {
        let screenWidth = UIScreen.main.bounds.width
        
        posterImageView.snp.makeConstraints { make in
            make.centerY.equalTo(infoContainerView.snp.top).offset(screenWidth * 0.07)
            make.leading.equalToSuperview().offset(32)
            make.width.equalToSuperview().multipliedBy(0.3)
            make.height.equalTo(posterImageView.snp.width).multipliedBy(1.5)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(posterImageView.snp.trailing).offset(20)
            make.top.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        releaseDateAndRuntimeLabel.snp.makeConstraints { make in
            make.leading.equalTo(titleLabel.snp.leading)
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.trailing.equalToSuperview().offset(-20)
        }
        
//        높이 곱하기 0.67은 너비임
//        너비 나누기 ? 은 높이다
//
//        h * 0.67 = w
//        1 * 0.67 = 0.67
//
//        w * ? = h
//        0.67 * ? = 1
//        ? = 1 / 0.67
        
        genresLabel.snp.makeConstraints { make in
            make.leading.equalTo(titleLabel.snp.leading)
            make.top.equalTo(releaseDateAndRuntimeLabel.snp.bottom).offset(4)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        overviewLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(24)
            make.top.equalTo(posterImageView.snp.bottom).offset(32)
            make.trailing.equalToSuperview().offset(-20)
        }
    }
    
    private func setConstraintsOfBackdropImageViewAndInfoContainerView() {
        backdropImageView.snp.makeConstraints { make in
            make.top.leading.trailing.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.35)
        }
        
        infoContainerView.snp.makeConstraints { make in
            make.top.equalTo(backdropImageView.snp.bottom).offset(-30)
            make.leading.trailing.bottom.equalToSuperview()
        }
    }
}
