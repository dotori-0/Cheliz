//
//  SettingsViewController.swift
//  Cheliz
//
//  Created by SC on 2022/09/25.
//

import UIKit
import FirebaseAnalytics

final class SettingsViewController: BaseViewController {
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        logEvent()
    }
    
    // MARK: - Setting Methods
    private func logEvent() {
        Analytics.logEvent("SettingsVC", parameters: nil)
    }
    
    private func setTableView() {
        settingsView.tableView.dataSource = self
        settingsView.tableView.delegate = self
    }
    
    // MARK: - Design Methods
    override func setUI() {
        super.setUI()
        
        navigationItem.title = Notice.settings
    }
}

// MARK: - UITableViewDataSource
extension SettingsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
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
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = .selectedBackgroundColor
        cell.selectedBackgroundView = backgroundView
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension SettingsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let section = SettingsSection(rawValue: indexPath.section)
        switch section {
            case .data:
                view.makeToast(Notice.updatePlanned,
                               duration: 1,
                               position: .center, style: self.toastStyle)
//                transit(to: BackupAndRestoreViewController(), transitionStyle: .push)
                Analytics.logEvent("Backup_Tapped", parameters: nil)
            case .language:
                print("language")
                view.makeToast(Notice.updatePlanned,
                               duration: 1,
                               position: .center, style: self.toastStyle)
                Analytics.logEvent("Language_Tapped", parameters: nil)
            case .design:
                print("design")
                if indexPath.row == 0 {
                    Analytics.logEvent("Fonts_Tapped", parameters: nil)
                    transit(to: FontsViewController(), transitionStyle: .push)
                } else {
                    view.makeToast(Notice.updatePlanned,
                                   duration: 1,
                                   position: .center, style: self.toastStyle)
                    Analytics.logEvent("Theme_Tapped", parameters: nil)
                }
            default:
                print("didSelectRowAt - default")
                view.makeToast(Notice.updatePlanned,
                               duration: 1,
                               position: .center, style: self.toastStyle)
        }
    }
}
