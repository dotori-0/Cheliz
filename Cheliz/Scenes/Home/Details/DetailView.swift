//
//  DetailView.swift
//  Cheliz
//
//  Created by SC on 2022/09/29.
//

import UIKit

class DetailView: BaseView {
    // MARK: - Properties
    let tableView = UITableView(frame: .zero, style: .insetGrouped).then {
        $0.register(WatchCountTableViewCell.self, forCellReuseIdentifier: WatchCountTableViewCell.reuseIdentifier)
        $0.register(RecordTableViewCell.self, forCellReuseIdentifier: RecordTableViewCell.reuseIdentifier)
        $0.register(AddRecordTableViewCell.self, forCellReuseIdentifier: AddRecordTableViewCell.reuseIdentifier)
//        $0.backgroundColor = .systemBackground
//        $0.backgroundColor = .systemMint
        
//        $0.backgroundView = UIImageView(image: .background)
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
