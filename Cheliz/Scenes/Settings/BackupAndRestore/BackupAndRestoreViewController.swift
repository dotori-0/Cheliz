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
    var backupFileNames: [String] = [] {
        didSet {
            backupAndRestoreView.tableView.reloadData()
        }
    }
    
    // MARK: - Initializers
    override func loadView() {
        view = backupAndRestoreView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTableView()
        fetchBackupFiles()
        print("🧃 \(backupFileNames.count)")
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
    
    // MARK: - Action Methods
    override func setActions() {
        setBackupButton()
        setImportBackupFileButton()
    }
    
    private func setBackupButton() {
        backupAndRestoreView.backupButton.addTarget(self, action: #selector(backupButtonClicked), for: .touchUpInside)
    }
    
    @objc private func backupButtonClicked() {
        createJSONBackupFile()
        saveBackupFile()
        fetchBackupFiles()
    }
    
    private func setImportBackupFileButton() {
        backupAndRestoreView.importBackupFileButton.addTarget(self, action: #selector(importBackupFileButtonClicked), for: .touchUpInside)
    }
    
    @objc private func importBackupFileButtonClicked() {
        let documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: [.archive], asCopy: true)
        documentPicker.delegate = self
        documentPicker.allowsMultipleSelection = false
        
        present(documentPicker, animated: true)
    }
    
    private func fetchBackupFiles() {
        if let backupFileNames = fetchBackupFilesFromDocuments() {
            self.backupFileNames = backupFileNames
        }
    }
}

// MARK: - UITableViewDataSource
extension BackupAndRestoreViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return backupFileNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BackupFileTableViewCell.reuseIdentifier, for: indexPath) as? BackupFileTableViewCell else {
            print("Cannot find BackupFileTableViewCell")
            return UITableViewCell()
        }
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = .selectedBackgroundColor
        cell.selectedBackgroundView = backgroundView
        
//        cell.fileNameLabel.text = "파일 이름"
        cell.fileNameLabel.text = backupFileNames[indexPath.row]
        cell.fileSizeLabel.text = "파일 크기"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - UITableViewDelegate
extension BackupAndRestoreViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .normal, title: nil) { action, view, completion in
            self.alert(title: Notice.deleteWarningTitle,
                       message: Notice.deleteBackupWarningMessage,
                       allowsCancel: true) { _ in
                self.deleteBackupFile(named: self.backupFileNames[indexPath.row])
                self.fetchBackupFiles()
            }
        }
        
        delete.image = UIImage(systemName: SFSymbol.trash)
        
        return UISwipeActionsConfiguration(actions: [delete])
    }
}

// MARK: -
extension BackupAndRestoreViewController: UIDocumentPickerDelegate {
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        // 선택한 파일의 URL
        guard let selectedFileURL = urls.first else {
            alert(message: "선택하신 파일을 찾을 수 없습니다.")
            return
        }
        
        guard let documentDirectoryPath = fetchDocumentDirectoryPath() else { return }
        
        let sandboxFileURL = documentDirectoryPath.appendingPathComponent(selectedFileURL.lastPathComponent)
    }
}
