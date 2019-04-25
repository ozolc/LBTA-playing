//
//  BaseTabBarController.swift
//  AppStoreJSONApis
//
//  Created by Maksim Nosov on 21/04/2019.
//  Copyright © 2019 Maksim Nosov. All rights reserved.
//

import UIKit

class BaseTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Создаем ViewControllers отображаемые в UITabBarController используя универсальный метод
        viewControllers = [
            createNavController(viewController: AppsPageController(), title: "Apps", imageName: "apps"),
            createNavController(viewController: AppsSearchController(), title: "Search", imageName: "search"),
            createNavController(viewController: UIViewController(), title: "Today", imageName: "today_icon")
        ]
    }
    
    // Универсальный метод для создания элеметов UITabBarController
    fileprivate func createNavController(viewController: UIViewController,
                                         title: String,
                                         imageName: String) -> UIViewController {
        
        let navController = UINavigationController(rootViewController: viewController) // Установить корневой ViewController для стека UINavigationController
        navController.navigationBar.prefersLargeTitles = true // отображение заголовка большими буквами
        viewController.navigationItem.title = title // Устанавливаем заголовок ViewController
        viewController.view.backgroundColor = .white // Цвет фона ViewController
        navController.tabBarItem.title = title // Заголовок элемента в UITabBarController
        navController.tabBarItem.image = UIImage(named: imageName) // Икона элемента в UITabBarController (normal state)
        
        return navController
    }
}
