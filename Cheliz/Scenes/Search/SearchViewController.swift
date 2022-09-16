//
//  SearchViewController.swift
//  Cheliz
//
//  Created by SC on 2022/09/14.
//

import UIKit

class SearchViewController: BaseViewController {
    // MARK: - Properties
    private let searchView = SearchView()
    
    private var searchText = ""
    private var searchResults: [MediaModel] = []
    
    
    // MARK: - Life Cycle
    override func loadView() {
        view = searchView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setCollectionView()
        setSearchController()
    }
    
    // MARK: - Setting Methods
    private func setCollectionView() {
        searchView.collectionView.dataSource = self
        searchView.collectionView.delegate = self
        
        searchView.collectionView.keyboardDismissMode = .onDrag
    }
    
    private func setSearchController() {
        searchView.searchController.searchResultsUpdater = self
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
    
    // MARK: - Search Methods
    private func search() {
        TMDBAPIManager.shared.fetchMultiSearchResults(query: searchText) { data in
            self.searchResults = ParsingManager.parseData(data)
            print("searchResults.count: \(self.searchResults.count)")
            self.searchView.collectionView.reloadData()
        }
    }
}

// MARK: - UICollectionViewDataSource
extension SearchViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        searchResults.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print(#function)
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCollectionViewCell.reuseIdentifier, for: indexPath) as? SearchCollectionViewCell else {
            print("Cannot find SearchCollectionViewCell")
            return UICollectionViewCell()
        }
        
//        cell.titleLabel.text = "탑건: 매버릭 (Top Gun: Maverick) 탑건: 매버릭 (Top Gun: Maverick)"
//        cell.releaseYearLabel.text = "2022-05-24"
//        cell.mediaTypeLabel.text = "movie"
        cell.showResult(with: searchResults[indexPath.row])
        print(cell.titleLabel.text)
        
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension SearchViewController: UICollectionViewDelegate {
    
}

// MARK: - UISearchResultsUpdating
extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        print(#function)
        guard let text = searchController.searchBar.text else {
            print("No text")  // 👻 화면에 검색하라고 띄워 주기
            return
        }
        
        searchText = text.lowercased()
        search()
    }
}


