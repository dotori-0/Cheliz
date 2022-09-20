//
//  HomeViewController.swift
//  Cheliz
//
//  Created by SC on 2022/09/12.
//

import UIKit
import SwiftUI
import RealmSwift

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
    
    // MARK: - Life Cycle
    override func loadView() {
        view = homeView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        fetchRealm()
    }
    
    // MARK: - Setting Methods
    private func setCollectionView() {
        homeView.collectionView.dataSource = self
        homeView.collectionView.delegate = self
    }
    
    // MARK: - Design Methods
    override func setUI() {
        super.setUI()
        
        navigationItem.title = "나의 리스트"
//        homeView.collectionView.backgroundColor = .systemMint
        setNavigationItem()
    }
    
    private func setNavigationItem() {
//        let sortButton = UIBarButtonItem(image: UIImage(systemName: "arrow.up.arrow.down"), style: .plain, target: self, action: #selector(sortButtonClicked))
//        let filterButton = UIBarButtonItem(image: UIImage(systemName: "line.3.horizontal.decrease"), style: .plain, target: self, action: #selector(filterButtonClicked))
        let sortButton = UIBarButtonItem(image: UIImage(systemName: "arrow.up.arrow.down"), primaryAction: nil, menu: sortMenu())
        let filterButton = UIBarButtonItem(image: UIImage(systemName: "line.3.horizontal.decrease"), primaryAction: nil, menu: sortMenu())
        navigationItem.rightBarButtonItems = [sortButton, filterButton]
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
                                                                position: .center) }
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
        let newestToOldest = UIAction(title: "최신 등록순") { _ in
            self.media = self.repository.sort(by: .newestToOldest)
        }
        
        let oldestToNewest = UIAction(title: "오래된 등록순", state: .on) { _ in
            self.media = self.repository.sort(by: .oldestToNewest)
        }
        
        let alphabetical = UIAction(title: "제목(오름차순)") { _ in
            self.media = self.repository.sort(by: .alphabetical)
        }
        
        let reverseAlphabetical = UIAction(title: "제목(내림차순)") { _ in
            self.media = self.repository.sort(by: .reverseAlphabetical)
        }
//
//        let a = UIAction(title: <#T##String#>, image: <#T##UIImage?#>, identifier: <#T##UIAction.Identifier?#>, discoverabilityTitle: <#T##String?#>, attributes: ., state: ., handler: <#T##UIActionHandler##UIActionHandler##(UIAction) -> Void#>)
        
        let menu = UIMenu(title: "정렬",
                          image: UIImage(systemName: "arrow.up.arrow.down"),
                          options: .singleSelection,
                          children: [newestToOldest, oldestToNewest, alphabetical, reverseAlphabetical])
        
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

//        cell.media = media[indexPath.row]
        cell.showSavedMedia(media[indexPath.row])
        
        return cell
    }
    
}

// MARK: - UICollectionViewDelegate
extension HomeViewController: UICollectionViewDelegate {
    
}

struct HomeViewController_Previews: PreviewProvider {
    static var previews: some View {
        TabBarController().toPreview()
    }
}
