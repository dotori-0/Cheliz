//
//  RecordTableViewCell.swift
//  Cheliz
//
//  Created by SC on 2022/10/02.
//

import UIKit

class RecordTableViewCell: BaseTableViewCell {
    // MARK: - Properties
//    let datePicker = MediaAndRecordPassableDatePicker()
    let datePicker = UIDatePicker()
    
    // MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
        // MARK: - Life Cycle
    override func prepareForReuse() {
        super.prepareForReuse()
        
//        datePicker.record = nil
    }
    
    // MARK: - Design Methods
    override func setUI() {
        [datePicker].forEach {
            contentView.addSubview($0)
        }
        
        backgroundColor = .secondarySystemGroupedBackground.withAlphaComponent(0.5)
        
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .compact
//        datePicker.calendar = Calendar(identifier: .gregorian)
        datePicker.locale = Locale(identifier: "ko")  // 👻 다국어 대응 시 수정하기
//        datePicker.maximumDate
    }
    
    override func setConstraints() {
        datePicker.snp.makeConstraints { make in
            make.bottom.equalTo(contentView.snp.centerY).offset(-4)
            make.leading.equalToSuperview().offset(24)
            make.width.equalToSuperview().multipliedBy(0.29)  // 0.28 숫자 짤림 2022.10.28  |  0.29는 10000년 되어야 짤림
        }
    }
}
