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
