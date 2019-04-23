//
//  BaseListController.swift
//  AppStoreJSONApis
//
//  Created by Maksim Nosov on 23/04/2019.
//  Copyright © 2019 Maksim Nosov. All rights reserved.
//

import UIKit

// Базовый класс для AppsSearchController, AppsController, AppsHorizontalController ...
// Чтобы не дублировать инициализатор с обязательным параметром collectionViewLayout
class BaseListController: UICollectionViewController {
    
    init() {
        //  Вызываем родительский инициализатор с обязательным!!! параметром Layout. Тем самым не указываем параметр collectionViewLayout при создании в BaseTabBarController
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
