//
//  SearchViewController.swift
//  Cheliz
//
//  Created by SC on 2022/09/14.
//

import UIKit
import Combine
import FirebaseAnalytics
import Toast

final class SearchViewController: BaseViewController {
    // MARK: - Properties
    private let searchView = SearchView()
    private let searchViewModel: SearchViewModel
    private let mediaAdditionViewModel: SearchResultMediaAdditionViewModel
    private var cancellables = Set<AnyCancellable>()
    
    // MARK: - Life Cycle
    init(searchViewModel: SearchViewModel,
         mediaAdditionViewModel: SearchResultMediaAdditionViewModel) {
        self.searchViewModel = searchViewModel
        self.mediaAdditionViewModel = mediaAdditionViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        view = searchView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setCollectionView()
        setSearchController()
        setSearchBar()
        bindViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        logEvent()
        checkNetwork()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        print("🚫", #function)
    }
    
    // MARK: - Binding
    private func bindViewModel() {
        bindSearchResultsUpdateType()
        bindScrollReset()
        bindMediaAdditionResult()
    }
    
    private func bindSearchResultsUpdateType() {
        searchViewModel.$searchResultsUpdateType
            .compactMap { $0 }
            .sink { [weak self] updateType in
                switch updateType {
                    case .newSearch:
                        self?.searchView.collectionView.reloadData()
                    case .pagination(let newIndexPaths):
                        self?.searchView.collectionView.performBatchUpdates {
                            self?.searchView.collectionView.insertItems(at: newIndexPaths)
                        }
                }
            }
            .store(in: &cancellables)
    }
    
    private func bindScrollReset() {
        searchViewModel.$shouldResetScroll
            .sink { [weak self] shouldReset in
                if shouldReset { self?.resetScrollPosition() }
            }
            .store(in: &cancellables)
    }
    
    private func bindMediaAdditionResult() {
        mediaAdditionViewModel.$additionResult
            .compactMap { $0 }
            .receive(on: DispatchQueue.main)
            .sink { [weak self] result in
                guard let self = self else { return }
                switch result {
                    case .success():
                        self.searchView.makeToast(Notice.addSucceeded,
                                                   duration: 1,
                                                   position: .center, style: self.toastStyle)
                    case .failure(let error):
                        self.alert(title: error.title,
                                   message: error.errorDescription)
                }
                self.mediaAdditionViewModel.resetAdditionResult()
            }
            .store(in: &cancellables)
    }
    
    // MARK: - Setting Methods
    private func logEvent() {
        Analytics.logEvent("SearchVC", parameters: [
          "search": "Search VC Opened"
        ])
    }
    
    private func setCollectionView() {
        searchView.collectionView.dataSource = self
        searchView.collectionView.delegate = self
        searchView.collectionView.prefetchDataSource = self
//        searchView.collectionView.isPagingEnabled = false
        searchView.collectionView.keyboardDismissMode = .onDrag
    }
    
    private func setSearchController() {
        searchView.searchController.searchResultsUpdater = self
//        searchView.searchController.searchBar.placeholder = Notice.Action.cancel
    }
    
    private func setSearchBar() {
        searchView.searchController.searchBar.delegate = self
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
        
//        navigationItem.backButtonTitle = "?"
//        searchView.searchController.hidesNavigationBarDuringPresentation = false
    }
    
    private func resetScrollPosition() {
        searchView.collectionView.scrollToItem(at: IndexPath(item: 0, section: 0),
                                               at: .top,
                                               animated: true)
    }
    
    // MARK: - Action Methods
//    private func
}

// MARK: - UICollectionViewDataSource
extension SearchViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return searchViewModel.searchResults.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SearchCollectionViewCell.reuseIdentifier, for: indexPath) as? SearchCollectionViewCell else {
            print("Cannot find SearchCollectionViewCell")
            return UICollectionViewCell()
        }
        
        let media = searchViewModel.searchResults[indexPath.row]
        
        cell.addButton.media = media
        cell.addButton.addTarget(self, action: #selector(addButtonClicked), for: .touchUpInside)
        cell.showResult(of: media)
        
        return cell
    }
    
    @objc private func addButtonClicked(sender: MediaPassableButton) {
        guard let media = sender.media else {
            print("Cannot find media in MediaPassableButton")  // 👻 alert
            return
        }
        
        mediaAdditionViewModel.add(media: media)
    }
}

// MARK: - UICollectionViewDelegate
extension SearchViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = DetailViewController()
        detailVC.isFromSearchView = true
        detailVC.media = searchViewModel.searchResults[indexPath.row]
        
        transit(to: detailVC, transitionStyle: .push)
    }
}

// MARK: - UISearchResultsUpdating
extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
//        print("🔄 updateSearchResults: \(searchController.searchBar.text ?? "nil")")

        guard let text = searchController.searchBar.text else { return }
        
        searchViewModel.search(query: text)
        return
    }
}

// MARK: - UISearchBarDelegate
extension SearchViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {   // updateSearchResults 호출됨

        searchViewModel.clearResults()
        searchView.searchAndAddLabel.isHidden = false
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchView.searchAndAddLabel.isHidden = true
    }
}

// MARK: - UIScrollViewDelegate
extension SearchViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
}


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
        for indexPath in indexPaths {  // indexPaths: prefetch되는 셀들
            searchViewModel.loadMoreIfNeeded(at: indexPath.item)
        }
    }
}

// MARK: - Network
extension SearchViewController {
    private func checkNetwork() {
        let alertHandler = { [weak self] in
            self?.alert(title: Notice.NetworkError.networkError,
                        message: Notice.NetworkError.networkErrorMessage,
                        actionTitle: Notice.Action.tryAgain, allowsCancel: true) { [weak self] _ in
                self?.checkNetwork()
            }
        }
        
        NetworkMonitor.shared.startMonitoring {
            print("🚨 alert")
            alertHandler()
        }
        
        print("🪺 \(NetworkMonitor.shared.monitor.currentPath.status)")
        
        if NetworkMonitor.shared.monitor.currentPath.status == .satisfied {
            // Connected
            print("// Connected")
        } else {
            // No connection
            print("// No connection")
            alertHandler()
        }
    }
}
