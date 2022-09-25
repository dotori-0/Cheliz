//
//  PosterImageView.swift
//  Cheliz
//
//  Created by SC on 2022/09/25.
//

import UIKit

class PosterImageView: UIImageView {
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUI() {
        contentMode = .scaleAspectFill
        layer.cornerRadius = 10
        clipsToBounds = true
    }
}
