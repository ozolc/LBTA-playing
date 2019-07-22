//
//  BackEnabledNavigationController.swift
//  AppStoreJSONApis
//
//  Created by Maksim Nosov on 22/07/2019.
//  Copyright © 2019 Maksim Nosov. All rights reserved.
//

import UIKit

class BackEnabledNavigationController: UINavigationController, UIGestureRecognizerDelegate {
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.interactivePopGestureRecognizer?.delegate = self
    }
    
//    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
//        return self.viewControllers.count > 1
//    }
}
