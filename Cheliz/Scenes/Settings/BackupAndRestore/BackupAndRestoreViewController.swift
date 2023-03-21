//
//  BackupAndRestoreViewController.swift
//  Cheliz
//
//  Created by SC on 2022/09/26.
//

import UIKit
import UniformTypeIdentifiers

final class BackupAndRestoreViewController: BaseViewController {
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
        decodeJSON()
    }
    
    // MARK: - Setting Methods
    private func setTableView() {
        backupAndRestoreView.tableView.dataSource = self
        backupAndRestoreView.tableView.delegate = self
    }
    
    // MARK: - Design Methods
    override func setUI() {
        super.setUI()
        
//        navigationItem.title = Notice.backupAndRestore
        navigationItem.title = SettingsTitle.Cell.backupAndRestore
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
        guard let chelizUTType = UTType(Notice.chelizUTType) else {
            alert(title: Notice.errorTitle,
                  message: Notice.errorInFileExtensionMessage)
            return
        }
        let documentPicker = UIDocumentPickerViewController(forOpeningContentTypes: [chelizUTType], asCopy: true)
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
        
        // ❔ cell 함수로 넘기기?
//        cell.fileNameLabel.text = "파일 이름"
        cell.fileNameLabel.text = backupFileNames[indexPath.row]
        cell.fileSizeLabel.text = "파일 크기"
        
        return cell
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let backupFileName = backupFileNames[indexPath.row]
        
        alert(title: Notice.restoreTitle,
              message: Notice.restoreMessage,
              allowsCancel: true) { _ in
            self.restore(with: backupFileName)
        }
    }
}

// MARK: -
extension BackupAndRestoreViewController: UIDocumentPickerDelegate {
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        // 선택한 파일의 URL
        guard let selectedFileURL = urls.first else {
            alert(message: Notice.cannotFindSelectedFile)
            return
        }
        
        importBackupFile(from: selectedFileURL) {
            self.fetchBackupFiles()
            self.backupAndRestoreView.makeToast(Notice.importBackupFileSucceeded,
                                                duration: 1,
                                                position: .center, style: self.toastStyle)
        }
    }
}
