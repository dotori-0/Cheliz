//
//  ProfileView.swift
//  Cheliz
//
//  Created by SC on 2022/10/04.
//

import UIKit

final class ProfileView: BaseView {
    // MARK: - Properties
    let defaultImageView = ProfileImageView(backgroundColor: .tintColor.withAlphaComponent(0.1))
    let profileImageView = ProfileImageView(backgroundColor: .clear)
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Design Methods
    override func setUI() {
        [defaultImageView, profileImageView].forEach {
            addSubview($0)
        }
        
        defaultImageView.image = .paleIcon
        
        round(clipsToBounds: true)
    }
    
    override func setConstraints() {
        defaultImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        profileImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
