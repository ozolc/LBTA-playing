//
//  AppsSearchController.swift
//  AppStoreJSONApis
//
//  Created by Maksim Nosov on 10/07/2019.
//  Copyright © 2019 Maksim Nosov. All rights reserved.
//

import UIKit

class AppsSearchController: UICollectionViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        collectionView.backgroundColor = .red
    }
    
    init() {
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
