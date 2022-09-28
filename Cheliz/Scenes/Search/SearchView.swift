//
//  SearchView.swift
//  Cheliz
//
//  Created by SC on 2022/09/14.
//

import UIKit

class SearchView: BaseView {
    // MARK: - Properties
    let searchController = UISearchController(searchResultsController: nil).then {
        $0.searchBar.placeholder = Notice.search
        $0.searchBar.setValue(Notice.search, forKey: "cancelButtonText")
        $0.searchBar.becomeFirstResponder()
    }
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout.init()).then {
        $0.register(SearchCollectionViewCell.self, forCellWithReuseIdentifier: SearchCollectionViewCell.reuseIdentifier)
    }

    // MARK: - Life Cycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Design Methods
    override func setUI() {
        [collectionView].forEach {
            addSubview($0)
        }
        setCollectionViewLayout()
    }
    
    override func setConstraints() {
//        testLabel.snp.makeConstraints { make in
//            make.center.equalToSuperview()
//        }
        
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setCollectionViewLayout() {
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 0
        layout.sectionInset = .zero
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        
        layout.itemSize = CGSize(width: screenWidth, height: screenHeight * 0.15)
        
        collectionView.collectionViewLayout = layout
    }
}
