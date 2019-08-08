//
//  UIApplication.swift
//  PodcastsCourseLBTA
//
//  Created by Maksim Nosov on 08/08/2019.
//  Copyright © 2019 Maksim Nosov. All rights reserved.
//

import UIKit

extension UIApplication {
    static func mainTabBarController() -> MainTabBarController? {
//        UIApplication.shared.keyWindow?.rootViewController as? MainTabBarController
        return shared.keyWindow?.rootViewController as? MainTabBarController
    }
}
