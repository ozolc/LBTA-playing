//
//  ReviewRowCell.swift
//  AppStoreJSONApis
//
//  Created by Maksim Nosov on 18/07/2019.
//  Copyright © 2019 Maksim Nosov. All rights reserved.
//

import UIKit

class ReviewRowCell: UICollectionViewCell {
    
    let reviewsController = ReviewsController()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .yellow
        
        addSubview(reviewsController.view)
        reviewsController.view.fillSuperview()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}
