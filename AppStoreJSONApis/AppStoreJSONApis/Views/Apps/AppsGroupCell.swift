//
//  AppsGroupCell.swift
//  AppStoreJSONApis
//
//  Created by Maksim Nosov on 23/04/2019.
//  Copyright © 2019 Maksim Nosov. All rights reserved.
//

import UIKit

class AppsGroupCell: UICollectionViewCell {
    
    let titleLabel = UILabel(text: "App Section", font: UIFont.boldSystemFont(ofSize: 30))
    
    let horizontalController = AppsHorizontalController() // Создали CollectionViewController, чтобы поместить его в ячейку. Этот CollectionViewController будет горизонтальным внутри ячейки для контроллера AppsController. Иными словами контроллер внутри ячейки. Интересная реализация.
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(titleLabel)
        titleLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor, padding: .init(top: 0, left: 16, bottom: 0, right: 0))

        addSubview(horizontalController.view) // Мы можем добавить только UIView.
        horizontalController.view.anchor(top: titleLabel.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
