//
//  MainTabBarController.swift
//  DrewsStore
//
//  Created by Andrii Zakharenkov on 3/19/19.
//  Copyright © 2019 Andrii Zakharenkov. All rights reserved.
//

import UIKit


class MainTabBarController: UITabBarController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        let todayVC = instantiateNavController(withVC: UIViewController(), withImage: #imageLiteral(resourceName: "today_icon"), withTitle: "Today")
        let appsVC = instantiateNavController(withVC: ApplicationsViewController(collectionViewLayout: UICollectionViewFlowLayout()), withImage: #imageLiteral(resourceName: "apps"), withTitle: "Apps")
        let searchVC = instantiateNavController(withVC: SearchViewController(collectionViewLayout: UICollectionViewFlowLayout()), withImage: #imageLiteral(resourceName: "search"), withTitle: "Search")
        
        viewControllers = [
            appsVC,
            todayVC,
            searchVC
        ]
    }
    
    private func instantiateNavController(withVC baseController: UIViewController, withImage image: UIImage, withTitle title: String) -> UINavigationController {
        
        baseController.navigationItem.title = title.uppercased()
        
        let navController = UINavigationController(rootViewController: baseController)
        navController.view.backgroundColor = .white
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        navController.navigationBar.prefersLargeTitles = true
        
        return navController
    }
    
}
