//
//  SearchResultCell.swift
//  AppStoreJSONApis
//
//  Created by Maksim Nosov on 21/04/2019.
//  Copyright © 2019 Maksim Nosov. All rights reserved.
//

import UIKit

// Класс для использования ячейки в AppsSearchController
class SearchResultCell: UICollectionViewCell {
    
    let appIconImageView: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .red
        iv.widthAnchor.constraint(equalToConstant: 64).isActive = true
        iv.heightAnchor.constraint(equalToConstant: 64).isActive = true
        iv.layer.cornerRadius = 12
        return iv
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "APP NAME"
        return label
    }()
    
    let categoryLabel: UILabel = {
        let label = UILabel()
        label.text = "Photos & Video"
        return label
    }()
    
    let ratingLabel: UILabel = {
        let label = UILabel()
        label.text = "9.26M"
        return label
    }()
    
    let getButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("GET", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 14)
        button.backgroundColor = UIColor(white: 0.95, alpha: 1)
        button.widthAnchor.constraint(equalToConstant: 88).isActive = true
        button.heightAnchor.constraint(equalToConstant: 32).isActive = true
        button.layer.cornerRadius = 16
        return button
    }()
    
    lazy var screenshot1ImgeView = self.createScreenShotImageView()
    lazy var screenshot2ImgeView = self.createScreenShotImageView()
    lazy var screenshot3ImgeView = self.createScreenShotImageView()
    
    // Создание изображений с программой
    func createScreenShotImageView() -> UIImageView {
        let imageView = UIImageView()
        imageView.backgroundColor = .blue
        return imageView
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // optional
        
        // StackView в котором находятся элементы без скриншотов приложения.
        let infoTopStackView = UIStackView(arrangedSubviews: [
            appIconImageView,
            
            // StackView в котором находятся элементы с названием, категорией и кол-вом загрузок.
            VerticalStackView(arrangedSubviews: [nameLabel, categoryLabel, ratingLabel]),
            
            getButton
            ])
        infoTopStackView.spacing = 12
        infoTopStackView.alignment = .center // расположение по центру ячейки. Перпендикулярно расположению заданному через AXIS
        
        // StackView в котором находятся скриншоты приложения.
        let screenshotStackView = UIStackView(arrangedSubviews: [screenshot1ImgeView, screenshot2ImgeView, screenshot3ImgeView])
        screenshotStackView.spacing = 12
        screenshotStackView.distribution = .fillEqually
        
        // StackView в котором находятся все элементы (вертикальное расположение)
        let overallStackView = VerticalStackView(arrangedSubviews: [infoTopStackView, screenshotStackView], spacing: 16)
        
        addSubview(overallStackView)
        overallStackView.fillSuperview(padding: .init(top: 16, left: 16, bottom: 16, right: 16))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
