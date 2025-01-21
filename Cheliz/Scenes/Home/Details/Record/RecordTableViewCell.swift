//
//  RecordTableViewCell.swift
//  Cheliz
//
//  Created by SC on 2022/10/02.
//

import UIKit

import RealmSwift
import WSTagsField

final class RecordTableViewCell: BaseTableViewCell {
    // MARK: - Properties
//    let datePicker = MediaAndRecordPassableDatePicker()
    let datePicker = UIDatePicker()
    let tagsField = WSTagsField().then {
        $0.spaceBetweenTags  = 5
        $0.spaceBetweenLines = 13
        $0.font = FontManager.preferredFont(ofSize: 14)
//        $0.textColor = .secondaryLabel
        $0.tintColor = .tintColor.withAlphaComponent(0.3)
        $0.selectedColor = .tintColor.withAlphaComponent(0.5)
        $0.delimiter = " "
//        $0.isDelimiterVisible = true
        $0.placeholder = Notice.addPeopleWatchedWith
//        $0.placeholderColor = .tintColor.withAlphaComponent(0.5)
        $0.placeholderColor = .secondaryLabel
        $0.placeholderAlwaysVisible = false
//        $0.returnKeyType = .
//        $0.acceptTagOption  // default: Return key
        $0.cornerRadius = 10
        
//        $0.backgroundColor = .systemYellow.withAlphaComponent(0.2)
        
        $0.maxHeight = 30
//        $0.maxHeight = 100
//        $0.showsHorizontalScrollIndicator = true  // 해도 버티컬만 됨
        
//        $0.layoutMargins = UIEdgeInsets(top: 2, left: 6, bottom: 2, right: 6)
        $0.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
    }
    
    // MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        tagsField.onDidAddTag = { field, tag in
            print("✏️ DidAddTag", tag.text)
            print("List of Tags Strings:", self.tagsField.tags.map({$0.text}))
        }
        
//        tagsField.onDidChangeText = { _, text in
//            print("DidChangeText", text)
//        }
        
        tagsField.onDidRemoveTag = { field, tag in
            print("✏️ DidRemoveTag", tag.text)
        }
        
        tagsField.onDidChangeHeightTo = { _, height in
            print("HeightTo", height)
            if height > self.tagsField.maxHeight { self.tagsField.scrollToBottom() }
//            처음부터 maxHeight 30으로 지정되고, 높이가 바뀌는 게 아니라 줄만 늘어나기 때문에 인식이 안 되어서 스크롤 안 됨
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
        // MARK: - Life Cycle
    override func prepareForReuse() {
        super.prepareForReuse()
        print("♻️", #function)
        
//        datePicker.record = nil
        
//        datePicker.date = Date.now
        
        tagsField.onDidRemoveTag = nil
        tagsField.removeTags()  // 앞에서 realm에서 없어져 버림..
//        tagsField.rem
    }
    
    // MARK: - Design Methods
    override func setUI() {
        [datePicker, tagsField].forEach {
            contentView.addSubview($0)
        }
        
        backgroundColor = .secondarySystemGroupedBackground.withAlphaComponent(0.5)
        
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .compact
//        datePicker.calendar = Calendar(identifier: .gregorian)
        datePicker.locale = Locale(identifier: Notice.korean)  // 👻 다국어 대응 시 수정하기
//        datePicker.maximumDate
//        datePicker.backgroundColor = .systemYellow
    }
    
    override func setConstraints() {
        datePicker.snp.makeConstraints { make in
            make.bottom.equalTo(contentView.snp.centerY).offset(-2)
            make.leading.equalToSuperview().offset(24)
//            make.width.equalToSuperview().multipliedBy(0.29)  // 0.28 숫자 짤림 2022.10.28  |  0.29는 10000년 되어야 짤림
        }
        
        tagsField.snp.makeConstraints { make in
//            tagsField.maxHeight = 20
            make.top.equalTo(contentView.snp.centerY).offset(2)
            make.leading.equalTo(datePicker)
            make.height.equalTo(datePicker).multipliedBy(1.3)
            make.trailing.equalToSuperview().offset(-24)
        }
    }
    
    // MARK: - Intenal Methods
    func addTags(of people: List<Person>) {
        people.forEach { person in
            tagsField.addTag(person.name)
        }
    }
}
