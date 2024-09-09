//
//  SearchView.swift
//  Cheliz
//
//  Created by SC on 2022/09/14.
//

import UIKit

final class SearchView: BaseView {
    // MARK: - Properties
    let searchController = UISearchController(searchResultsController: nil).then {
        $0.searchBar.placeholder = Notice.searchMedia
        $0.searchBar.setValue(Notice.Action.cancel, forKey: "cancelButtonText")
        $0.searchBar.becomeFirstResponder()
    }
    
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout.init()).then {
        $0.register(SearchCollectionViewCell.self, forCellWithReuseIdentifier: SearchCollectionViewCell.reuseIdentifier)
    }
    
    let searchAndAddLabel = CustomLabel(textSize: 15, textColor: .secondaryLabel).then {
        $0.text = "타이틀로 검색 후 리스트에 추가해 보세요"
        $0.numberOfLines = 0
        $0.textAlignment = .center
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
        [collectionView, searchAndAddLabel].forEach {
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
        
        searchAndAddLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
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
