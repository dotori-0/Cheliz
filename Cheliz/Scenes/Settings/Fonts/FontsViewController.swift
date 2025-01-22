//
//  FontsViewController.swift
//  Cheliz
//
//  Created by SC on 2022/10/03.
//

import UIKit

final class FontsViewController: BaseViewController {
    // MARK: - Properties
    let fontsView = FontsView()

    // MARK: - Life Cycle
    override func loadView() {
        view = fontsView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setTableView()
    }
    
    // MARK: - Setting Methods
    private func setTableView() {
        fontsView.tableView.dataSource = self
        fontsView.tableView.delegate = self
    }
    
    // MARK: - Design Methods
    override func setUI() {
        super.setUI()
        
        navigationItem.title = Notice.fontSettings
    }
}

// MARK: - UITableViewDataSource
extension FontsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FontTableViewCell.reuseIdentifier,
                                                       for: indexPath) as? FontTableViewCell else {
            print("Cannot find FontTableViewCell")
            return UITableViewCell()
        }

        let font = AppFont.allCases[indexPath.row]
        cell.configure(with: font)
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = .selectedBackgroundColor
        cell.selectedBackgroundView = backgroundView
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension FontsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if UserDefaults.fontPreference == AppFont.allCases[indexPath.row].rawValue {
            return
        }
        
        // 기존에 선택한 폰트
        if let selectedFont = AppFont(rawValue: UserDefaults.fontPreference),
           let previousIndex = AppFont.allCases.firstIndex(of: selectedFont), let previousCell = tableView.cellForRow(at: IndexPath(row: previousIndex, section: indexPath.section)) {
            previousCell.accessoryType = .none
        }
        
        // 새로 선택한 폰트
        if let cell = tableView.cellForRow(at: indexPath) {
            cell.accessoryType = .checkmark
        }
        
        FontManager.configureFont(to: AppFont.allCases[indexPath.row])
    }
}
