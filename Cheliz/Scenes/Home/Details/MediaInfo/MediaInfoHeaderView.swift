//
//  MediaInfoHeaderView.swift
//  Cheliz
//
//  Created by SC on 2022/09/29.
//

import UIKit

class MediaInfoHeaderView: BaseView {
    // MARK: - Properties
    var directorsExist = true
    var castExists = true
    
    var directorItemHeight: CGFloat = 10
    var castItemHeight: CGFloat = 10
    
    let backdropImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
    }
    
    let infoContainerView = UIView().then {
//        $0.backgroundColor = .systemBackground//.withAlphaComponent(0.5)
//        $0.backgroundColor = .systemBackground.withAlphaComponent(0.4)
//        $0.backgroundColor = .clear
//        $0.backgroundColor = .systemBackground
        print($0)
    }
    
    let gradientImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.image = .gradient
    }
    
    let shadowView = UIView()
    let posterView = PosterView()
//    let posterImageView = PosterImageView()
    
    let titleLabel = CustomLabel(textSize: 18)
    
    let releaseDateAndRuntimeLabel = CustomLabel(textSize: 15, textColor: .secondaryLabel)
    
//    let runtimeLabel = CustomLabel(textSize: 16, textColor: .quaternaryLabel)
    
    let genresLabel = CustomLabel(textSize: 15, textColor: .secondaryLabel).then {
        $0.numberOfLines = 2
    }
    
    let overviewLabel = CustomLabel(textSize: 14, textColor: .secondaryLabel).then {
        $0.numberOfLines = 0
        $0.sizeToFit()
    }
    
    let directorCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout.init()).then {
        $0.register(CreditsCollectionViewCell.self, forCellWithReuseIdentifier: CreditsCollectionViewCell.reuseIdentifier)
        $0.backgroundColor = .clear
//        $0.backgroundColor = .systemGray3
    }
    
    let castCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout.init()).then {
        $0.register(CreditsCollectionViewCell.self, forCellWithReuseIdentifier: CreditsCollectionViewCell.reuseIdentifier)
        $0.backgroundColor = .clear
//        $0.backgroundColor = .systemGray5
    }
    
    // 1
    let gradientLayer = CAGradientLayer()
    
    // MARK: - Initializers
    init(directorItemHeight: CGFloat, castItemHeight: CGFloat) {
        self.directorItemHeight = directorItemHeight
        self.castItemHeight = castItemHeight
        super.init(frame: .zero)
        
//        setUI()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        print("🍒 MediaHeaderView init")

//        infoContainerView.setGradient()

        // 2
        gradientLayer.colors = [UIColor.systemPink.cgColor, UIColor.clear.cgColor]
        infoContainerView.layer.addSublayer(gradientLayer)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Life Cycle
    override func layoutIfNeeded() {
        super.layoutIfNeeded()
        
        // 3
        gradientLayer.frame = infoContainerView.bounds
    }
    
    // MARK: - Design Methods
    override func setUI() {
//        backgroundColor = .systemYellow
//        overviewLabel.backgroundColor = .systemIndigo
        
//        infoContainerView.layer.borderColor = UIColor.label.cgColor
//        infoContainerView.layer.borderWidth = 0.5
        infoContainerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        infoContainerView.layer.cornerRadius = 30
//        infoContainerView.setGradient()
        
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        
//        let colors: [CGColor] = [
//           .init(red: 0, green: 0.9810667634, blue: 0.5736914277, alpha: 1),
//           .init(red: 0.5563425422, green: 0.9793455005, blue: 0, alpha: 1),
//           .init(red: 0.9994240403, green: 0.9855536819, blue: 0, alpha: 1)
//        ]
//
//        gradientLayer.colors = colors
        gradientLayer.colors = [UIColor.systemPink.cgColor, UIColor.yellow.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0, y: 1)

        infoContainerView.layer.addSublayer(gradientLayer)
//        infoContainerView.backgroundColor = .systemMint
        infoContainerView.layer.addSublayer(gradientLayer)
//        layer.insertSublayer(gradientLayer, at: 0)
        overviewLabel.layer.addSublayer(gradientLayer)
        
        // Gradient Image View
        gradientImageView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        gradientImageView.layer.cornerRadius = 30
        gradientImageView.clipsToBounds = true
        
        
        // Shadow
//        infoContainerView.backgroundColor = .systemBackground//.withAlphaComponent(0.5)
//        infoContainerView.backgroundColor = .systemPink
//        infoContainerView.addShadow(radius: 20, opacity: 0.4, shadowColor: UIColor.systemGray.cgColor)
        
//        infoContainerView.addShadow(radius: 20, opacity: 0.5, shadowColor: UIColor.secondaryLabel.cgColor)
//        infoContainerView.addShadow(radius: 20, opacity: 0.5, shadowColor: UIColor.darkGray.cgColor)
//        infoContainerView.addShadow(radius: 12, opacity: 0.3, shadowColor: UIColor.label.cgColor)  // 일단 이걸로
        // secondaryLabel보다 darkGray 가 낫다
//        infoContainerView.addShadow(radius: 12, opacity: 1, shadowColor: UIColor.tintColor.cgColor)  // 일단 이걸로
//        infoContainerView.addShadowWithBezierPath(radius: 20, opacity: 1, shadowColor: UIColor.tintColor.cgColor)
        
        shadowView.layer.cornerRadius = 10
        shadowView.backgroundColor = .systemBackground  // 왜 백그라운드 컬러를 지정해야만 그림자가 나오는지..? .clear도 그림자가 안 나옴
//        shadowView.addShadow(radius: 20, opacity: 0.5, shadowColor: UIColor.secondaryLabel.cgColor) // O
//        shadowView.addShadow(radius: 20, opacity: 0.5, shadowColor: UIColor.darkGray.cgColor) // O
        shadowView.addShadow(radius: 12, opacity: 0.3, shadowColor: UIColor.label.cgColor) // O
//        shadowView.addShadow(radius: 20, opacity: 0.4, shadowColor: UIColor.systemGray.cgColor)

        
//        [gradientImageView, shadowView, posterImageView, titleLabel, releaseDateAndRuntimeLabel, genresLabel, overviewLabel, directorCollectionView, castCollectionView].forEach {
//            infoContainerView.addSubview($0)
//        }
        
        [gradientImageView, shadowView, posterView, titleLabel, releaseDateAndRuntimeLabel, genresLabel, overviewLabel].forEach {
            infoContainerView.addSubview($0)
        }
        
        [backdropImageView, infoContainerView].forEach {
            addSubview($0)
        }
        
        setCollectionViewLayout()
//        setDirectorCollectionViewLayout()
//        setCastCollectionViewLayout()
    }
    
    override func setConstraints() {
        setConstraintsOfSubviewsOfInfoContainerView()
        setConstraintsOfBackdropImageViewAndInfoContainerView()
    }
    
    private func setConstraintsOfSubviewsOfInfoContainerView() {
        gradientImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        let screenWidth = UIScreen.main.bounds.width
        
        posterView.snp.makeConstraints { make in
            make.centerY.equalTo(infoContainerView.snp.top).offset(screenWidth * 0.07)
            make.leading.equalToSuperview().offset(32)
            make.width.equalToSuperview().multipliedBy(0.3)
            make.height.equalTo(posterView.snp.width).multipliedBy(1.5)
        }
        
        shadowView.snp.makeConstraints { make in
            make.edges.equalTo(posterView)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.leading.equalTo(posterView.snp.trailing).offset(24)
            make.top.equalToSuperview().offset(24)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        releaseDateAndRuntimeLabel.snp.makeConstraints { make in
            make.leading.equalTo(titleLabel.snp.leading)
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.trailing.equalToSuperview().offset(-20)
        }
        
//        runtimeLabel.snp.makeConstraints { make in
//            make.leading.equalTo(releaseDateLabel)
//        }
//        h * 0.67 = w
//        1 * 0.67 = 0.67
//
//        w * ? = h
//        0.67 * ? = 1
//        ? = 1 / 0.67 -> 1.5
        
        genresLabel.snp.makeConstraints { make in
            make.leading.equalTo(titleLabel.snp.leading)
            make.top.equalTo(releaseDateAndRuntimeLabel.snp.bottom).offset(4)
            make.trailing.equalToSuperview().offset(-20)
        }
        
        overviewLabel.snp.makeConstraints { make in
            make.leading.equalTo(posterView.snp.leading)
            make.top.equalTo(posterView.snp.bottom).offset(24)
//            make.top.equalTo(genresLabel.snp.bottom).offset(40)
            make.trailing.equalToSuperview().offset(-24)
        }
 
//        setCollectionViewLayout()
        setDirectorCollectionViewLayout()
        setCastCollectionViewLayout()
    }
    
    func setConstraintsOfCollectionViews() {
        if directorsExist {
            infoContainerView.addSubview(directorCollectionView)
            directorCollectionView.snp.makeConstraints { make in
                make.leading.trailing.equalToSuperview()
                make.top.equalTo(overviewLabel.snp.bottom).offset(24)
                make.height.equalTo(UIScreen.main.bounds.height * 0.2)
//                make.height.equalTo(directorItemHeight)
                // 컬렉션뷰가 아예 안 나옴
//                DispatchQueue.main.async {
//                    make.height.equalTo(self.directorItemHeight)
//                }
            }
        }
        
        if castExists {
            infoContainerView.addSubview(castCollectionView)
            castCollectionView.snp.makeConstraints { make in
                make.leading.trailing.equalToSuperview()
                make.height.equalTo(UIScreen.main.bounds.height * 0.2)
//                make.height.equalTo(castItemHeight)
                // 컬렉션뷰가 아예 안 나옴
//                DispatchQueue.main.async {
//                    make.height.equalTo(self.castItemHeight)
//                }
                if directorsExist {
                    make.top.equalTo(directorCollectionView.snp.bottom).offset(24)
                } else {
                    make.top.equalTo(overviewLabel.snp.bottom).offset(24)
                }
            }
        }
    }
    
    func updateConstraintsOfCollectionViews(directorsHeight: CGFloat, castHeight: CGFloat) {
        if directorsExist {
            directorCollectionView.snp.updateConstraints { make in
                make.height.equalTo(directorsHeight)
            }
        }
        
        if castExists {
            castCollectionView.snp.updateConstraints { make in
                make.height.equalTo(castHeight)
            }
        }
    }

    
    func setConstraintsOfCollectionViews2() {  // setConstraintsOfCollectionViews()랑 비교했을 때 어느 게 더 나은 코드인지?
        if directorsExist {
            infoContainerView.addSubview(directorCollectionView)
            directorCollectionView.snp.makeConstraints { make in
                make.leading.trailing.equalToSuperview()
                make.top.equalTo(overviewLabel.snp.bottom).offset(24)
                make.height.equalTo(UIScreen.main.bounds.height * 0.2)
            }
            if castExists {
                infoContainerView.addSubview(directorCollectionView)
                castCollectionView.snp.makeConstraints { make in
                    make.leading.trailing.equalToSuperview()
                    make.top.equalTo(directorCollectionView.snp.bottom).offset(24)
                    make.height.equalTo(UIScreen.main.bounds.height * 0.2)
                }
            }
        } else {
            if castExists {
                infoContainerView.addSubview(directorCollectionView)
                castCollectionView.snp.makeConstraints { make in
                    make.leading.trailing.equalToSuperview()
                    make.top.equalTo(overviewLabel.snp.bottom).offset(24)
                    make.height.equalTo(UIScreen.main.bounds.height * 0.2)
                }
            }
        }
    }

    
    private func setConstraintsOfBackdropImageViewAndInfoContainerView() {
        backdropImageView.snp.makeConstraints { make in
//            make.top.leading.trailing.equalToSuperview()
//            make.height.equalToSuperview().multipliedBy(0.35)
            make.top.centerX.equalToSuperview()
            make.width.equalTo(UIScreen.main.bounds.width)
            make.height.equalTo(UIScreen.main.bounds.height * 0.25)
        }
        
        infoContainerView.snp.makeConstraints { make in
            make.top.equalTo(backdropImageView.snp.bottom).offset(-30)
//            make.leading.trailing.bottom.equalToSuperview()
            make.width.equalTo(UIScreen.main.bounds.width)
            make.centerX.bottom.equalToSuperview()
        }
        
//        infoContainerView.setGradient()
    }
    
    // MARK: - Collection View Layout
//    private func setCollectionViewLayout() {
    func setCollectionViewLayout() {
        print("🐋")
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 8
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 32, bottom: 0, right: 32)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = 0

//        let screenWidth = UIScreen.main.bounds.width
//        let screenHeight = UIScreen.main.bounds.height
//        let itemWidth = screenWidth / 5

//        layout.itemSize = CGSize(width: itemWidth, height: itemWidth * 1.5)
//        layout.itemSize = CGSize(width: itemWidth, height: itemHeight)

        directorCollectionView.collectionViewLayout = layout
        castCollectionView.collectionViewLayout = layout

        directorCollectionView.isScrollEnabled = false
    }
    
    func setDirectorCollectionViewLayout() {
        print("🐋")
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 8
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 32, bottom: 0, right: 32)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = 0
        
//        let screenWidth = UIScreen.main.bounds.width
//        let screenHeight = UIScreen.main.bounds.height
//        let itemWidth = screenWidth / 5
        
//        layout.itemSize = CGSize(width: itemWidth, height: directorItemHeight)
        print("🎬", directorItemHeight)
        
        directorCollectionView.collectionViewLayout = layout
//        castCollectionView.collectionViewLayout = layout
        
        directorCollectionView.isScrollEnabled = false
    }
    
    func setCastCollectionViewLayout() {
        print("🐋")
        let layout = UICollectionViewFlowLayout()
        let spacing: CGFloat = 8
        layout.scrollDirection = .horizontal
        layout.sectionInset = UIEdgeInsets(top: 0, left: 32, bottom: 0, right: 32)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = 0
        
//        let screenWidth = UIScreen.main.bounds.width
//        let screenHeight = UIScreen.main.bounds.height
//        let itemWidth = screenWidth / 5
        
//        layout.itemSize = CGSize(width: itemWidth, height: itemWidth * 1.5)
//        layout.itemSize = CGSize(width: itemWidth, height: castItemHeight)
        print("🍿", castItemHeight)
        
//        directorCollectionView.collectionViewLayout = layout
        castCollectionView.collectionViewLayout = layout
        
//        directorCollectionView.isScrollEnabled = false
    }
    
//    private func setCollectionViewCompositionalLayout() {
//        var configuration = UICollectionViewCompositionalLayoutConfiguration()
//
//
//        let layout = UICollectionViewCompositionalLayout(
//
//        collectionView.setCollectionViewLayout(layout, animated: true)
//    }
    
    // MARK: - Internal Methods
    func showMediaInfo(media: Media) {
        if let backdropPath = media.backdropPath {
            let url = URL(string: Endpoint.higerResImageConfigurationURL + backdropPath)
            backdropImageView.kf.setImage(with: url)
        }
        
        if let posterPath = media.posterPath {
            let url = URL(string: Endpoint.imageConfigurationURL + posterPath)
            posterView.posterImageView.kf.setImage(with: url)
//            posterImageView.kf.setImage(with: url)
        }
        
        titleLabel.text = media.title
        releaseDateAndRuntimeLabel.text = "\(media.releaseDate)"
//        releaseDateAndRuntimeLabel.text = "\(media.releaseDate)⋅・･·⸱•\(media.runtime)"
        
        // 통신 여기서?
        fetchDetails(of: media)
        genresLabel.text = ""
        
        overviewLabel.text = media.overview  // overview 처음에 받아오는 것으로 수정 후 추가
        
        fetchGenres(of: media)
//        media.genreIds.forEach {
////            genresLabel.text! += "\($0)"
//            genresLabel.text = "\(genresLabel.text ?? "")\($0) "
//        }
    }

    // MARK: - Networking Methods
    // 외않되 Cannot convert return expression of type '()' to return type '(Int?, String?)'
//    private func fetchDetails(media: Media) -> (Int?, String?) {
//        TMDBAPIManager.shared.fetchDetails(mediaType: MediaType(rawValue: media.mediaType) ?? .movie, mediaID: media.TMDBid) { data in
//            let runtimeAndOverview = ParsingManager.parseDetails(data)
//
//            return runtimeAndOverview
//        }
//        return (0, "")
//    }
    
    private func fetchDetails(of media: Media) {
        print("🤍 MediaHeaderView fetchDetails")
        TMDBAPIManager.shared.fetchDetails(mediaType: MediaType(rawValue: media.mediaType) ?? .movie, mediaID: media.TMDBid) { data in
//            let runtimeAndOverview = ParsingManager.parseDetails(data)
//
//            if let runtime = runtimeAndOverview.0 {
//                if self.releaseDateAndRuntimeLabel.text == "" {
//                    self.releaseDateAndRuntimeLabel.text = "\(runtime)분"  //  ･ ⸱ •
//                } else {
//                    self.releaseDateAndRuntimeLabel.text = "\(self.releaseDateAndRuntimeLabel.text ?? "") ･ \(runtime)분"  //  ･ ⸱ •
//                }
//            }
//
//            if let overview = runtimeAndOverview.1 {
//                self.overviewLabel.text = overview
//            }
            
            let runtime = ParsingManager.parseDetails2(data)
            
            if let runtime = runtime {
                if self.releaseDateAndRuntimeLabel.text == "" {
                    self.releaseDateAndRuntimeLabel.text = "\(runtime)\(Notice.minute)"  //  ･ ⸱ •
                } else {
                    self.releaseDateAndRuntimeLabel.text = "\(self.releaseDateAndRuntimeLabel.text ?? "") ･ \(runtime)\(Notice.minute)"  //  ･ ⸱ •
                }
            }
            
        }
    }
    
    private func fetchGenres(of media: Media) {
        TMDBAPIManager.shared.fetchGenreNames(mediaType: MediaType(rawValue: media.mediaType) ?? .movie) { data in
            let genresDict = ParsingManager.parseGenres(data)
            
            media.genreIds.forEach {
    //            genresLabel.text! += "\($0)"
                
                
                self.genresLabel.text = "\(self.genresLabel.text ?? "")\(genresDict[$0] ?? "")  "  // 👻 joined 써 보기
            }
        }
    }
}
