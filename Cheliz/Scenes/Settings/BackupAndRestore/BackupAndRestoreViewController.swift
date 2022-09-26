//
//  BackupAndRestoreViewController.swift
//  Cheliz
//
//  Created by SC on 2022/09/26.
//

import UIKit

class BackupAndRestoreViewController: BaseViewController {
    // MARK: - Properties
    let backupAndRestoreView = BackupAndRestoreView()
    
    // MARK: - Initializers
    override func loadView() {
        view = backupAndRestoreView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTableView()
    }
    
    // MARK: - Setting Methods
    private func setTableView() {
        backupAndRestoreView.tableView.dataSource = self
        backupAndRestoreView.tableView.delegate = self
    }
    
    // MARK: - Design Methods
    override func setUI() {
        super.setUI()
        
        navigationItem.title = "백업 및 복원"
    }
}

// MARK: - UITableViewDataSource
extension BackupAndRestoreViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BackupFileTableViewCell.reuseIdentifier, for: indexPath) as? BackupFileTableViewCell else {
            print("Cannot find BackupFileTableViewCell")
            return UITableViewCell()
        }
        
        cell.fileNameLabel.text = "파일 이름"
        cell.fileSizeLabel.text = "파일 크기"
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension BackupAndRestoreViewController: UITableViewDelegate {
    
}
