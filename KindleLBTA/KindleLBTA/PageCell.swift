//
//  PageCell.swift
//  KindleLBTA
//
//  Created by Maksim Nosov on 26/03/2019.
//  Copyright © 2019 Maksim Nosov. All rights reserved.
//

import UIKit

class PageCell: UICollectionViewCell {

    let textLabel: UILabel = {
        let label = UILabel()
        label.text = "Some text for our label Some text for our label Some text for our label Some text for our label Some text for our label Some text for our label "
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(textLabel)
//        textLabel.frame = CGRect(x: 0, y: 0, width: 100, height: 200)
        
        textLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        textLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10).isActive = true
        textLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        textLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
