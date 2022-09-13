//
//  BaseTableViewCell.swift
//  Cheliz
//
//  Created by SC on 2022/09/12.
//

import UIKit

import SnapKit
import Then

class BaseTableViewCell: UITableViewCell {
    // MARK: - Functions
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUI()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUI () { }
    
    func setConstraints() { }
}
