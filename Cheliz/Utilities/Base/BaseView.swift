//
//  BaseView.swift
//  Cheliz
//
//  Created by SC on 2022/09/12.
//

import UIKit

class BaseView: UIView {
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUI()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setting Methods
    func setUI() { }
    
    func setConstraints() { }
}
