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
    
    let imageView: UIImageView = {
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
        button.backgroundColor = .darkGray
        button.widthAnchor.constraint(equalToConstant: 88).isActive = true
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .yellow
        
        // StackView в котором находятся элементы с названием, категорией и кол-вом загрузок.
        let labelsStackView = UIStackView(arrangedSubviews: [
            nameLabel, categoryLabel, ratingLabel
            ])
        labelsStackView.axis = .vertical
        
        // StackView в котором находятся все элементы.
        let stackView = UIStackView(arrangedSubviews: [
            imageView, labelsStackView, getButton
            ])
        stackView.spacing = 12
        stackView.alignment = .center // расположение по центру ячейки. Перпендикулярно расположению заданному через AXIS
        
        addSubview(stackView)
        
        // Отключим Autoresizing mask переводится в Auto Layout constraints
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        stackView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
