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
        
        let homeVC = HomeViewController()
        let homeNC = UINavigationController(rootViewController: homeVC)
        
        let filmListSymbolImage = UIImage(systemName: "list.and.film")
        homeNC.tabBarItem.image = filmListSymbolImage
        homeNC.tabBarItem.image = UIImage(named: "bank")
        homeNC.tabBarItem.imageInsets = UIEdgeInsets(top: 8, left: 0, bottom: -8, right: 0)
        
//        let filmListItem = UITabBarItem(title: nil, image: filmListSymbolImage, tag: 0)
        
//        let filmListItem = UITabBarItem(title: nil, image: filmListSymbolImage, selectedImage: filmListSymbolImage)
//        filmListItem.imageInsets = UIEdgeInsets(top: 26, left: 0, bottom: -26, right: 0)
//        homeNC.tabBarItem = filmListItem
        
        // 두 가지 방법 모두 O
        setViewControllers([homeNC], animated: true)
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
}
