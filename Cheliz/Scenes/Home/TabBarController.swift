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
//        homeNC.tabBarItem.title = nil
        homeNC.tabBarItem.image = UIImage(systemName: "list.and.film")
//        homeNC.tabBarItem.selectedImage = UIImage(systemName: "list.and.film")
//        homeNC.tabBarItem.titlePositionAdjustment = .zero
//        homeNC.tabBarItem.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
//        tabBar.items?.first?.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        
        setViewControllers([homeNC], animated: true)
    }
}
