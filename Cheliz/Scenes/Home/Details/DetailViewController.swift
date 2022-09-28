//
//  DetailViewController.swift
//  Cheliz
//
//  Created by SC on 2022/09/29.
//

import UIKit

class DetailViewController: BaseViewController {
    // MARK: - Properties
    let detailView = DetailView()
    
    // MARK: - Life Cycle
    override func loadView() {
        view = detailView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTableView()
    }
    
    // MARK: - Setting Methods
    private func setTableView() {
        detailView.tableView.dataSource = self
        detailView.tableView.delegate = self
    }
}

// MARK: - UITableViewDataSource
extension DetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return MediaInfoHeaderView()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 600
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

// MARK: - UITableViewDelegate
extension DetailViewController: UITableViewDelegate {
    
}

