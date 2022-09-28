//
//  SearchViewController.swift
//  Cheliz
//
//  Created by SC on 2022/09/14.
//

import UIKit
import Toast

class SearchViewController: BaseViewController {
    // MARK: - Properties
    private let searchView = SearchView()
    
    private var searchText = ""
//    private var searchResults: [MediaModel] = []
    private var searchResults: [Media] = []
    private var page = 1
    private var totalPages = 0
    private var isPaginating = false
    
    
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
        searchView.collectionView.prefetchDataSource = self
        
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
    
    // MARK: - Action Methods
//    private func
    
    // MARK: - Search Methods
    private func search() {
        print("isPaginating: \(isPaginating)")
        TMDBAPIManager.shared.fetchMultiSearchResults(query: searchText, page: page) { data in
            print("fetched page \(self.page)")
//            self.searchResults = ParsingManager.parseData(data)
//            self.searchResults = ParsingManager.parseDataToRealmModel(data)
            let data = ParsingManager.parseDataToRealmModel(data)
//            self.searchResults.append(contentsOf: data.0)
//            self.searchResults = data.0
            
            if self.isPaginating {
                self.searchResults.append(contentsOf: data.0)
            } else {
//                self.searchView.collectionView.scrollsToTop = true
                self.searchResults = data.0
                self.totalPages = data.1
            }
            
            let titles = data.0.map { media in
                media.title
            }
            print(titles)
            
            print("searchResults.count: \(self.searchResults.count)")
//            self.totalPages = data.1
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
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCollectionViewCell.reuseIdentifier, for: indexPath) as? SearchCollectionViewCell else {
            print("Cannot find SearchCollectionViewCell")
            return UICollectionViewCell()
        }
        
        let media = searchResults[indexPath.row]
        
//        cell.media = media
//        cell.addCompletionHandler = { self.searchView.makeToast(Notice.addSucceeded,
//                                                                duration: 1,
//                                                                position: .center) }
//        cell.addErrorHandler = { self.alert(title: Notice.errorTitle,
//                                            message: Notice.errorInAddMessage) }
        
        cell.addButton.media = media
        cell.addButton.addTarget(self, action: #selector(addButtonClicked), for: .touchUpInside)

//        cell.showResult {
//            self.alert(title: Notice.errorTitle,
//                       message: Notice.errorInSearchMessage)
//        }
        cell.showResult(of: media)
        
        return cell
    }
    
    @objc private func addButtonClicked(sender: MediaPassableButton) {
//        if let media = media, let addErrorHandler = addErrorHandler, let addCompletionHandler = addCompletionHandler {
//            let repository = MediaRepository()
//            repository.add(media: media, completionHandler: addCompletionHandler, errorHandler: addErrorHandler)
//        }
        guard let media = sender.media else {
            print("Cannot find media in MediaPassableButton")  // 👻 alert
            return
        }
        
        let repository = MediaRepository()
        
        if repository.sameMediaExists(as: media) {
//            alert(title: nil,
//            alert(title: Notice.sameMediaAlreadyExistsTitle,
            alert(title: "",
                  message: Notice.sameMediaAlreadyExistsMessage)
            return
        }
        
        repository.add(media: media) {
            self.searchView.makeToast(Notice.addSucceeded,
                                      duration: 1,
                                      position: .center, style: self.toastStyle)
        } errorHandler: {
            self.alert(title: Notice.errorTitle,
                       message: Notice.errorInAddMessage)
        }
        
//        Record(id: <#T##ObjectId#>, watchCount: 0, watchedDate: [Date.now], rate: <#T##Double#>, watchedWith: <#T##String?#>, review: <#T##String?#>)
//
//        repository.add(review: ) {
//            self.searchView.makeToast(Notice.addSucceeded,
//                                      duration: 1,
//                                      position: .center, style: self.toastStyle)
//        } errorHandler: {
//            self.alert(title: Notice.errorTitle,
//                       message: Notice.errorInAddMessage)
//        }

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
          
        isPaginating = false
        page = 1
        searchText = text.lowercased()
        if !searchResults.isEmpty { searchView.collectionView.scrollToItem(at: [0, 0], at: .top, animated: true) }
        search()
    }
}

// MARK: - UIScrollViewDelegate
//extension SearchViewController {
//    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        isPaginating = true
//        print("🍬", totalPages)
////        print("🍰", scrollView.contentOffset)  // 하동
////        print("☕️", searchView.collectionView.contentOffset)
//        let contentOffset = scrollView.contentOffset.y  // 처음: 1740.5
//        let collectionViewHeight = searchView.collectionView.contentSize.height  // 하동
////        let scrollViewContentSizeHeight = scrollView.contentSize.height
//        // searchView.collectionView.contentSize.height = scrollView.contentSize.height
////        let scrollViewHeight = scrollView.frame.size.height
//        let remainingHeight = collectionViewHeight * 0.33
//        // collectionViewHeight * 0.65 = 1659.84   // remainingHeight = collectionViewHeight * 0.35
//        // collectionViewHeight * 0.67 = 1710.912  // remainingHeight = collectionViewHeight * 0.33
//        // collectionViewHeight * 0.68 = 1736.448  // remainingHeight = collectionViewHeight * 0.32
//
//        // contentSize.height은 왜인지 너무 커서(2553.6) remainingHeight이 collectionViewHeight의 20%일 때는 더이상 로딩이 안 됨.
//        // scrollView.frame.height은 왜인지 896.0에서 바뀌지가 않아서, 더이상 로딩이 안 됨
//        // scrollView.frame.size.height도 마찬가지
//
//        print("🍋 contentOffset: \(contentOffset)")
//        print("🍒 collectionViewHeight: \(collectionViewHeight)")  // 2553.6
////        print("🍒 scrollViewContentSizeHeight: \(scrollViewContentSizeHeight)")
////        print("🍏 scrollViewHeight: \(scrollViewHeight)")
//        print("🫐 remainingHeight: \(remainingHeight)")  // 1021.44
//        print("🍒 - 🫐: \(collectionViewHeight - remainingHeight)")
////        print(page < totalPages)
//        print("📃 page: \(page)")
//
//        if contentOffset > collectionViewHeight - remainingHeight && page < totalPages {
////        if contentOffset > scrollViewHeight - remainingHeight && page < totalPages {
//            page += 1
//            search()
//        }
//    }
//}

// MARK: - UICollectionViewDataSourcePrefetching
extension SearchViewController: UICollectionViewDataSourcePrefetching {
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        print("🍬", totalPages)
        for indexPath in indexPaths {
            if searchResults.count - 1 == indexPath.item && page < totalPages {
                isPaginating = true
                page += 1
                search()
            }
        }
//        print("=====\(indexPaths)=====")
    }
}
