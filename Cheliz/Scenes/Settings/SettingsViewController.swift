//
//  SettingsViewController.swift
//  Cheliz
//
//  Created by SC on 2022/09/25.
//

import UIKit

class SettingsViewController: BaseViewController {
    // MARK: - Properties
    let settingsView = SettingsView()
    
    // MARK: - Life Cycle
    override func loadView() {
        view = settingsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setTableView()
    }
    
    // MARK: - Setting Methods
    private func setTableView() {
        settingsView.tableView.dataSource = self
        settingsView.tableView.delegate = self
    }
    
    // MARK: - Design Methods
    override func setUI() {
        super.setUI()
        
        navigationItem.title = "설정"
    }
}

// MARK: - UITableViewDataSource
extension SettingsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> Stringç? {
        let section = SettingsSection(rawValue: section)
        switch section {
            case .data:
                return SettingsTitle.Header.data
            case .language:
                return SettingsTitle.Header.language
            case .design:
                return SettingsTitle.Header.design
            default:
                print("titleForHeaderInSection - default")
                return nil
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let section = SettingsSection(rawValue: section)
        switch section {
            case .data, .language:
                return 1
            case .design:
                return 2
            default:
                print("numberOfRowsInSection - default")
                return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingsTableViewCell.reuseIdentifier, for: indexPath) as? SettingsTableViewCell else {
            print("Cannot find SettingsTableViewCell")
            return UITableViewCell()
        }
        
//        let section = indexPath.section
        let section = SettingsSection(rawValue: indexPath.section)
        switch section {
            case .data:
                cell.configureCell(imageName: SFSymbol.cloud, title: SettingsTitle.Cell.backupAndRestore)
            case .language:
                cell.configureCell(imageName: SFSymbol.globe, title: SettingsTitle.Cell.mediaInfoLanguage)
            case .design:
                if indexPath.row == 0 {
                    cell.configureCell(imageName: SFSymbol.font, title: SettingsTitle.Cell.font)
                } else {
                    cell.configureCell(imageName: SFSymbol.theme, title: SettingsTitle.Cell.theme)
                }
            default:
                print("cellForRowAt - default")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56
    }
}

// MARK: - UITableViewDelegate
extension SettingsViewController: UITableViewDelegate {
    
}
