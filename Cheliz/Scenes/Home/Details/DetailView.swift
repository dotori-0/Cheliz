//
//  DetailView.swift
//  Cheliz
//
//  Created by SC on 2022/09/29.
//

import UIKit

class DetailView: BaseView {
    // MARK: - Properties
    let tableView = UITableView(frame: .zero, style: .grouped).then {
        $0.register(SettingsTableViewCell.self, forCellReuseIdentifier: SettingsTableViewCell.reuseIdentifier)
    }
    
    // MARK: - Life Cycle
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
