//
//  SearchViewController.swift
//  Cheliz
//
//  Created by SC on 2022/09/14.
//

import UIKit

class SearchViewController: BaseViewController {
    // MARK: - Properties
    let searchView = SearchView()
    
    // MARK: - Life Cycle
    override func loadView() {
        view = searchView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchView.collectionView.dataSource = self
        searchView.collectionView.delegate = self
    }
    
    // MARK: - Design Methods
    override func setUI() {
        super.setUI()
        
        setNavigationItem()
    }
    
    private func setNavigationItem() {
        navigationItem.searchController = searchView.searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        
        navigationItem.title = Notice.search
        
//        navigationController?.navigationBar.topItem?.title = ""  // nil: Back, 리터럴: 앞 화면의 타이틀까지 바뀜
//        navigationItem.backButtonTitle = "?"
    }
}

// MARK: - UICollectionViewDataSource
extension SearchViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCollectionViewCell.reuseIdentifier, for: indexPath) as? SearchCollectionViewCell else {
            print("Cannot find SearchCollectionViewCell")
            return UICollectionViewCell()
        }
        
        cell.titleLabel.text = "탑건: 매버릭 (Top Gun: Maverick) 탑건: 매버릭 (Top Gun: Maverick)"
        cell.releaseYearLabel.text = "2022-05-24"
        cell.mediaTypeLabel.text = "movie"
        
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension SearchViewController: UICollectionViewDelegate {
    
}
