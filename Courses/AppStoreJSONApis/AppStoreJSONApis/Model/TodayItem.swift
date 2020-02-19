//
//  TodayItem.swift
//  AppStoreJSONApis
//
//  Created by Maksim Nosov on 18.02.2020.
//  Copyright © 2020 Maksim Nosov. All rights reserved.
//

import UIKit

struct TodayItem {
    
    let category: String
    let title: String
    let image: UIImage
    let description: String
    let backgroundColor: UIColor
    
    // enum
    let cellType: CellType
    
    let apps: [FeedResult]
    
    enum CellType: String {
        case single, multiple
    }
    
}
