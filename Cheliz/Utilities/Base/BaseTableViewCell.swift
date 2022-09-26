//
//  BaseTableViewCell.swift
//  Cheliz
//
//  Created by SC on 2022/09/26.
//

import UIKit

class BaseTableViewCell: UITableViewCell {
    // MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUI()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Design Methods
    func setUI() { }
    
    func setConstraints() { }
}
