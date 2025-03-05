//
//  FontsView.swift
//  Cheliz
//
//  Created by SC on 2022/10/03.
//

import UIKit

final class FontsView: BaseView {
    // MARK: - Properties
    let tableView = UITableView(frame: .zero, style: .insetGrouped).then {
        $0.register(FontTableViewCell.self, forCellReuseIdentifier: FontTableViewCell.reuseIdentifier)
    }

    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Design Methods
    override func setUI() {
        addSubview(tableView)
    }
    
    override func setConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
