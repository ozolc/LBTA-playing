//
//  BaseTabBarController.swift
//  AppStoreJSONApis
//
//  Created by Maksim Nosov on 12.02.2020.
//  Copyright © 2020 Maksim Nosov. All rights reserved.
//

import UIKit

class BaseTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewControllers = [
            createNavController(viewController: UIViewController(),
                                title: "Today", imageName: "today_icon"),
            createNavController(viewController: UIViewController(),
                                title: "Apps", imageName: "apps"),
            createNavController(viewController: AppsSearchController(),
                                title: "Search", imageName: "search"),
        ]
    }
    
    fileprivate func createNavController(viewController: UIViewController,
                                         title: String,
                                         imageName: String) -> UIViewController {
        
        
        
        let navController = UINavigationController(rootViewController: viewController)
        navController.navigationBar.prefersLargeTitles = true
        viewController.navigationItem.title = title
        viewController.view.backgroundColor = .white
        navController.tabBarItem.title = title
        navController.tabBarItem.image = UIImage(named: imageName)
        
        if #available(iOS 13.0, *) {
            let navBarAppearance = UINavigationBarAppearance()
            navBarAppearance.configureWithDefaultBackground()
            navBarAppearance.backgroundColor = .white
            navController.navigationBar.standardAppearance = navBarAppearance
            navController.navigationBar.scrollEdgeAppearance = navBarAppearance
        }
        
        return navController
    }
}
