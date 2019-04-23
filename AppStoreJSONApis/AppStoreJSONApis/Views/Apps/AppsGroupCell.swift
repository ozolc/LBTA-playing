//
//  AppsGroupCell.swift
//  AppStoreJSONApis
//
//  Created by Maksim Nosov on 23/04/2019.
//  Copyright © 2019 Maksim Nosov. All rights reserved.
//

import UIKit

// Расширение, чтобы не дублировать создание Label. Указываем необходимые параметры в convenience инициализаторе
extension UILabel {
    convenience init(text: String, font: UIFont) {
        self.init(frame: .zero)
        self.text = text
        self.font = font
    }
}

class AppsGroupCell: UICollectionViewCell {
    
    let titleLabel = UILabel(text: "App Section", font: UIFont.boldSystemFont(ofSize: 30))
    
    let horizontalController = AppsHorizontalController() // Создали CollectionViewController, чтобы поместить его в ячейку. Этот CollectionViewController будет горизонтальным внутри ячейки для контроллера AppsController. Иными словами контроллер внутри ячейки. Интересная реализация.
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .lightGray
        
        addSubview(titleLabel)
        titleLabel.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor)

        addSubview(horizontalController.view) // Мы можем добавить только UIView.
        horizontalController.view.backgroundColor = .blue
        horizontalController.view.anchor(top: titleLabel.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
