//
//  AppsPageHeader.swift
//  AppStoreJSONApis
//
//  Created by Maksim Nosov on 25/04/2019.
//  Copyright © 2019 Maksim Nosov. All rights reserved.
//

import UIKit

// Класс для заголовка Supplementary заголовка назначенного для AppsPageController
class AppsPageHeader: UICollectionReusableView {
    
    // Создать горизонтальный контроллер
    let appHeaderHorizontalController = AppsHeaderHorizontalController()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(appHeaderHorizontalController.view)
        appHeaderHorizontalController.view.fillSuperview()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
