//
//  NotesTableViewCell.swift
//  Cheliz
//
//  Created by SC on 2022/10/03.
//

import UIKit

final class NotesTableViewCell: BaseTableViewCell {
    // MARK: - Properties
    let notesTextView = UITextView().then {
        $0.backgroundColor = .clear
        $0.font = FontManager.preferredFont(ofSize: 14)
        $0.text = Notice.addNotes
        $0.textColor = .secondaryLabel
    }
    
    // MARK: - Initializers
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Design Methods
    override func setUI() {
        contentView.addSubview(notesTextView)
        backgroundColor = .secondarySystemGroupedBackground.withAlphaComponent(0.5)
    }
    
    override func setConstraints() {
        notesTextView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.bottom.equalToSuperview().inset(15)
        }
    }
}
