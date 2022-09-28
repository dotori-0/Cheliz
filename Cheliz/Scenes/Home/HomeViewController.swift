//
//  HomeViewController.swift
//  Cheliz
//
//  Created by SC on 2022/09/12.
//

import UIKit
import SwiftUI

import RealmSwift
//import Toast

class HomeViewController: BaseViewController {
    // MARK: - Properties
    private let homeView = HomeView()
    private let repository = MediaRepository()
    private var media: Results<Media>! {
        didSet {
            print("Media Changed")
            homeView.collectionView.reloadData()
        }
    }
    
//    var toastStyle = ToastStyle()
    
    // MARK: - Life Cycle
    override func loadView() {
        view = homeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("🏡", #function)
        
//        TMDBAPIManager.shared.fetchMultiSearchResults(query: "top-gun")
        
//        for family in UIFont.familyNames {
//            print("=====\(family)=====")
//
//            for name in UIFont.fontNames(forFamilyName: family) {
//                print(name)
//            }
//        }
        
        print("🐰 Realm is located at:", repository.realm.configuration.fileURL!)
        
        setCollectionView()
        setDeleteAction()
        
//        let encodedRealm = repository.encode()  // 👻 guard-let
//        print("🥳", encodedRealm)
//
//        guard let encodedJson = repository.encode2() else {
//            print("encodedJson is nil")
//            return
//        }
//        print("🤯", encodedJson)
//        createJSONBackupFile()
//        saveBackupFile()  //
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("🏡", #function)
        
//        fetchRealm()
        sortAndFilter()
        print("🫐", media.count)
    }
    
    // MARK: - Setting Methods
    private func setCollectionView() {
        homeView.collectionView.dataSource = self
        homeView.collectionView.delegate = self
    }
    
    // MARK: - Design Methods
    override func setUI() {
        print("Home", #function)
        super.setUI()
        
        setNavigationItem()
    }
    
    override func setConstraints() {
        super.setConstraints()
    }
    
    private func setNavigationItem() {
        navigationItem.title = "나의 리스트"
        let sortButton = UIBarButtonItem(image: UIImage(systemName: SFSymbol.sort), primaryAction: nil, menu: sortMenu())
        let filterButton = UIBarButtonItem(image: UIImage(systemName: SFSymbol.filter), primaryAction: nil, menu: filterMenu())
        navigationItem.rightBarButtonItems = [filterButton, sortButton]
    }
    
    // MARK: - Action Methods
    override func setActions() {
        setSearchButton()
        setDeleteAction()
    }
    
    private func setSearchButton() {
        homeView.searchButton.addTarget(self, action: #selector(searchButtonClicked), for: .touchUpInside)
    }
    
    @objc private func searchButtonClicked() {
        let searchVC = SearchViewController()
        transit(to: searchVC, transitionStyle: .push)
    }
    
    private func setDeleteAction() {
        let deleteCompletionHandler = { self.homeView.makeToast(Notice.deleteSucceeded,
                                                                duration: 1,
                                                                position: .center, style: self.toastStyle) }
        let deleteErrorHandler = { self.alert(title: Notice.errorTitle,
                                              message: Notice.errorInDeleteMessage) }
        
        homeView.deleteCompletion = { row in
            self.alert(title: Notice.deleteWarningTitle,
                       message: Notice.deleteWarningMessage,
                       allowsCancel: true) { _ in
                self.repository.delete(media: self.media[row],
                                       completionHandler: deleteCompletionHandler,
                                       errorHandler: deleteErrorHandler)
                self.homeView.collectionView.reloadData()
            }
        }
    }
    
    private func sortMenu() -> UIMenu {
        print("🥢 sort")
        
//        func sortAndFilter() {
//            self.media = self.repository.sortAndFilter()
//        }
        
        
        let newestToOldest = UIAction(title: MenuTitle.newestToOldest,
                                      state: SortingOrder.newestToOldest.state) { _ in
            UserDefaultsHelper.standard.sortingOrder = SortingOrder.newestToOldest.rawValue
//            self.media = self.repository.sort(by: .newestToOldest)
            self.sortAndFilter()
        }
        
        let oldestToNewest = UIAction(title: MenuTitle.oldestToNewest,
                                      state: SortingOrder.oldestToNewest.state) { _ in
            UserDefaultsHelper.standard.sortingOrder = SortingOrder.oldestToNewest.rawValue
//            self.media = self.repository.sort(by: .oldestToNewest)
            self.sortAndFilter()
        }
        
        let alphabetical = UIAction(title: MenuTitle.alphabetical,
                                    state: SortingOrder.alphabetical.state) { _ in
            UserDefaultsHelper.standard.sortingOrder = SortingOrder.alphabetical.rawValue
//            self.media = self.repository.sort(by: .alphabetical)
            self.sortAndFilter()
        }
        
        let reverseAlphabetical = UIAction(title: MenuTitle.reverseAlphabetical,
                                           state: SortingOrder.reverseAlphabetical.state) { _ in
            UserDefaultsHelper.standard.sortingOrder = SortingOrder.reverseAlphabetical.rawValue
//            self.media = self.repository.sort(by: .reverseAlphabetical)
            self.sortAndFilter()
        }
//
//        let a = UIAction(title: <#T##String#>, image: <#T##UIImage?#>, identifier: <#T##UIAction.Identifier?#>, discoverabilityTitle: <#T##String?#>, attributes: ., state: ., handler: <#T##UIActionHandler##UIActionHandler##(UIAction) -> Void#>)
        
        let menu = UIMenu(title: MenuTitle.sort,
                          options: .singleSelection,
                          children: [newestToOldest, oldestToNewest, alphabetical, reverseAlphabetical])
        
        return menu
    }
    
    private func filterMenu() -> UIMenu {
        let showWatched = UIAction(title: MenuTitle.showWatched,
                                   image: UIImage(systemName: SFSymbol.eye),
                                   state: FilterOption.showWatched.state) { _ in
            UserDefaultsHelper.standard.filterOption = FilterOption.showWatched.rawValue
//            self.media = self.repository.filter(by: .showWatched)
            self.sortAndFilter()
        }
        
        let hideWatched = UIAction(title: MenuTitle.hideWatched,
                                   image: UIImage(systemName: SFSymbol.eyeSlash),
                                   state: FilterOption.hideWatched.state) { _ in
            UserDefaultsHelper.standard.filterOption = FilterOption.hideWatched.rawValue
//            self.media = self.repository.filter(by: .hideWatched)
            self.sortAndFilter()
        }
        
        let menu = UIMenu(title: MenuTitle.filter,
                          options: .singleSelection,
                          children: [showWatched, hideWatched])
        
        return menu
    }
    
//    @objc private func sortButtonClicked() {
//
//    }
//
//    @objc private func filterButtonClicked() {
//
//    }
    
    // MARK: - Realm Methods
    private func fetchRealm() {
        media = repository.fetch()
    }
    
//    private func deleteRealm(media: Media) {
//        repository.delete(media: media,
//                          completionHandler: <#T##() -> Void#>,
//                          errorHandler: <#T##() -> Void#>)
//    }
    
    private func sortAndFilter() {
        media = repository.sortAndFilter()
    }
}

// MARK: - UICollectionViewDataSource
extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return 10
        return media.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCell.reuseIdentifier, for: indexPath) as? HomeCollectionViewCell else {
            print("Cannot find HomeCollectionViewCell")
            return UICollectionViewCell()
        }
        
//        cell.titleLabel.text = "\(indexPath)"
//        cell.titleLabel.text = "탑건: 매버릭 (Top Gun: Maverick)"
//        cell.releaseYearLabel.text = "\(Date.now)"

//        cell.media = media[indexPath.row]   // 👻 이렇게 한 번만 보내 주는 게 나을지?
        let media = media[indexPath.row]
        cell.showSavedMedia(media)
        cell.setCheckButtonImage(watched: media.watched)
        cell.checkButton.media = media
        cell.checkButton.addTarget(self, action: #selector(checkButtonClicked), for: .touchUpInside)
        
        return cell
    }
    
    @objc private func checkButtonClicked(sender: MediaPassableButton) {
        guard let media = sender.media else {
            print("Cannot find media in MediaPassableButton")  // 👻 alert
            return
        }
        
        repository.toggleWatched(of: media) {
            self.alert(title: Notice.errorTitle, message: Notice.errorInCheckMessage)
        }
        homeView.collectionView.reloadData()
    }
    
}

// MARK: - UICollectionViewDelegate
extension HomeViewController: UICollectionViewDelegate {
    
}

//struct HomeViewController_Previews: PreviewProvider {
//    static var previews: some View {
//        HomeViewController().toPreview()
//    }
//}
