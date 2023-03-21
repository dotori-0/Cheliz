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
//        fontsView.tableView.allowsSelection = false
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
                
        if indexPath.row == 0 {
            cell.fontLabel.text = Notice.systemFont
            cell.button.isSelected = false
            
        } else {
            cell.fontLabel.text = Notice.baMeringue
            cell.button.isSelected = true
        }
        
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
        
        if indexPath.row == 0 {
            view.makeToast(Notice.updatePlanned,
                           duration: 1,
                           position: .center, style: self.toastStyle)
        } 
    }
}
