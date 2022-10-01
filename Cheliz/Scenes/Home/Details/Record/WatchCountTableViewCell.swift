//
//  WatchCountTableViewCell.swift
//  Cheliz
//
//  Created by SC on 2022/10/02.
//

import UIKit

class WatchCountTableViewCell: BaseTableViewCell {
    // MARK: - Properties
    let countLabel = CustomLabel(textSize: 18)
    let stepper = MediaPassableStepper()
    
    // MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Design Methods
    override func setUI() {
        [countLabel, stepper].forEach {
            contentView.addSubview($0)
        }
    }
    
    override func setConstraints() {
        countLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(24)
            make.centerY.equalToSuperview()
            make.trailing.equalTo(stepper.snp.leading).offset(-20)
        }
        
        stepper.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalToSuperview().offset(-24)
        }
    }
    
    // MARK: - Intenal Methods
    func setCountLabel(as count: Int) {
        countLabel.text = "\(count)"
    }
}
