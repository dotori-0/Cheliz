//
//  PosterView.swift
//  Cheliz
//
//  Created by SC on 2022/10/04.
//

import UIKit

final class PosterView: BaseView {
    // MARK: - Properties
    let defaultImageView = PosterImageView(backgroundColor: .tintColor.withAlphaComponent(0.1))
    let posterImageView = PosterImageView(backgroundColor: .clear)
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        
//        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Design Methods
//    private func setUI() {
//        defaultImageView.image = .paleIcon
//    }
    
    override func setUI() {
        [defaultImageView, posterImageView].forEach {
            addSubview($0)
        }
        
        defaultImageView.image = .paleIcon
    }
    
    override func setConstraints() {
        defaultImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        posterImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
