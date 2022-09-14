//
//  HomeViewController.swift
//  Cheliz
//
//  Created by SC on 2022/09/12.
//

import UIKit

class HomeViewController: BaseViewController {
    // MARK: - Properties
    let homeView = HomeView()
    
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
    }
    
    private func setSearchButton() {
        homeView.searchButton.addTarget(self, action: #selector(searchButtonClicked), for: .touchUpInside)
    }
    
    @objc private func searchButtonClicked() {
        let searchVC = SearchViewController()
        transit(to: searchVC, transitionStyle: .push)
    }
}

// MARK: - UICollectionViewDataSource
extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeCollectionViewCell.reuseIdentifier, for: indexPath) as? HomeCollectionViewCell else {
            print("Cannot find HomeCollectionViewCell")
            return UICollectionViewCell()
        }
        
//        cell.titleLabel.text = "\(indexPath)"
        cell.titleLabel.text = "탑건: 매버릭 (Top Gun: Maverick)"
        cell.releaseYearLabel.text = "\(Date.now)"
        
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension HomeViewController: UICollectionViewDelegate {
    
}
