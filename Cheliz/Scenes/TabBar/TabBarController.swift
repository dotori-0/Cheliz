//
//  TabBarController.swift
//  Cheliz
//
//  Created by SC on 2022/09/14.
//

import UIKit

class TabBarController: UITabBarController {
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
        
        let searchVC = SearchViewController()
        let searchNC = UINavigationController(rootViewController: searchVC)
        searchNC.tabBarItem.image = UIImage(systemName: SFSymbol.magnifyingGlass,
                                             withConfiguration: UIImage.SymbolConfiguration(font: .systemFont(ofSize: 20)))?.withBaselineOffset(fromBottom: UIFont.systemFontSize * 1.5)
        
        let homeVC = HomeViewController()
//        let homeVC = BackupAndRestoreViewController()
        let homeNC = UINavigationController(rootViewController: homeVC)
        
//        let filmListSymbolImage = UIImage(systemName: "list.and.film",
//                                          withConfiguration: UIImage.SymbolConfiguration(font: .systemFont(ofSize: 24)))?.withBaselineOffset(fromBottom: UIFont.systemFontSize * 3)
        homeNC.tabBarItem.image = UIImage(systemName: SFSymbol.checklist,
                                          withConfiguration: UIImage.SymbolConfiguration(font: .systemFont(ofSize: 20)))?.withBaselineOffset(fromBottom: UIFont.systemFontSize * 1.5)
//        homeNC.tabBarItem.image = UIImage(named: "bank")
//        homeNC.tabBarItem.imageInsets = UIEdgeInsets(top: 8, left: 0, bottom: -8, right: 0)
        
//        let filmListItem = UITabBarItem(title: nil, image: filmListSymbolImage, tag: 0)
        
//        let filmListItem = UITabBarItem(title: nil, image: filmListSymbolImage, selectedImage: filmListSymbolImage)
//        filmListItem.imageInsets = UIEdgeInsets(top: 26, left: 0, bottom: -26, right: 0)
//        homeNC.tabBarItem = filmListItem
        
        let settingsVC = SettingsViewController()
//        let settingsVC = BackupAndRestoreViewController()
        let settingsNC = UINavigationController(rootViewController: settingsVC)
        settingsNC.tabBarItem.image = UIImage(systemName: SFSymbol.settings,
                                              withConfiguration: UIImage.SymbolConfiguration(font: .systemFont(ofSize: 20)))?.withBaselineOffset(fromBottom: UIFont.systemFontSize * 1.5)
        
        // 두 가지 방법 모두 O
//        setViewControllers([homeNC], animated: true)
        setViewControllers([searchNC, homeNC, settingsNC], animated: true)
        selectedIndex = 1
//        viewControllers = [homeNC]
        
        // 클래스 자체가 UITabBarController 상속이기 때문에 tabBarController 접근 X
        // You are subclassing UITabBarController not UIViewController so you don't have, or at least don't need, the property tabBarController.
//        tabBarController?.tabBar.items?[0] = UITabBarItem(title: nil, image: filmListSymbolImage, tag: 0)
//        tabBarController?.tabBar.items?[0].image = filmListSymbolImage
//        guard tabBarController != nil else {
//            print("No tabBarController")
//            return
//        }

//        guard let items = tabBar.items else {
//            print("No items")
//            return
//        }
//        print("items.count: \(items.count)")
//
//        for item in items {
//            let tabBarHeight = tabBar.frame.height
//            let imageHeight = item.image?.size.height ?? 0
//            print("tabBarHeight: \(tabBarHeight)")
//            print("imageHeight: \(imageHeight)")
//            item.imageInsets = UIEdgeInsets(top: 116, left: 0, bottom: -6, right: 0)
//
//        }
//        tabBarController?.tabBar.items?[0].imageInsets = UIEdgeInsets(top: 116, left: 0, bottom: -6, right: 0)
//        tabBar.items = [filmListItem]  // 적용 X
//        viewControllers = [homeNC]
    }
    
    
}

extension TabBarController: UITabBarControllerDelegate {
//    tabbar
//    tabb
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        print("🥯")
        let index = tabBarController.selectedIndex
        if index != 0 {
            let searchVC = SearchViewController()
            let searchNC = UINavigationController(rootViewController: searchVC)
            searchNC.tabBarItem.image = UIImage(systemName: SFSymbol.magnifyingGlass,
                                                 withConfiguration: UIImage.SymbolConfiguration(font: .systemFont(ofSize: 20)))?.withBaselineOffset(fromBottom: UIFont.systemFontSize * 1.5)
            
            tabBarController.viewControllers?[0] = searchNC
        }
    }
}
