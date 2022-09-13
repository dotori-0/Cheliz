//
//  HomeView.swift
//  Cheliz
//
//  Created by SC on 2022/09/12.
//

import UIKit

class HomeView: BaseView {
    // MARK: - Properties
//    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: .init()).then {
//        $0.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: HomeCollectionViewCell.reuseIdentifier)
//    }
    let collectionView: UICollectionView = {
        let view = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout.init())
        view.register(HomeCollectionViewCell.self, forCellWithReuseIdentifier: HomeCollectionViewCell.reuseIdentifier)
        return view
    }()
    
    let searchButton = UIButton().then {
        var configuration = UIButton.Configuration.filled()
        configuration.image = UIImage(systemName: "magnifyingglass",
                                      withConfiguration: UIImage.SymbolConfiguration(pointSize: 22))
        configuration.cornerStyle = .capsule
        $0.configuration = configuration
        
        $0.layer.shadowColor = UIColor.black.cgColor
        $0.layer.shadowOffset = .zero
        $0.layer.shadowRadius = 12
        $0.layer.shadowOpacity = 0.2
    }

    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Methods
    override func setUI() {
        [collectionView, searchButton].forEach {
            addSubview($0)
        }
        setCollectionViewLayout()
    }
    
    override func setConstraints() {
        collectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        searchButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().offset(-24)
            make.bottom.equalTo(safeAreaLayoutGuide).offset(-24)
            make.width.equalToSuperview().multipliedBy(0.15)
            make.height.equalTo(searchButton.snp.width)
        }
    }
    
    private func setCollectionViewLayout() {
        print(#function)
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 0
        layout.sectionInset = .zero
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        
        layout.itemSize = CGSize(width: screenWidth, height: screenHeight * 0.1)
        
        collectionView.collectionViewLayout = layout
    }
    
    private func getCollectionViewLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 0
        layout.sectionInset = .zero
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        
        let screenWidth = UIScreen.main.bounds.width
        let screenHeight = UIScreen.main.bounds.height
        
        layout.itemSize = CGSize(width: screenWidth, height: screenHeight * 0.1)
        
        return layout
    }
}
