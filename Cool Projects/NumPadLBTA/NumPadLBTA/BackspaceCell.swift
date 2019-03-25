//
//  BackspaceCell.swift
//  NumPadLBTA
//
//  Created by Maksim Nosov on 25/03/2019.
//  Copyright © 2019 Maksim Nosov. All rights reserved.
//

import UIKit

class BackspaceCell: UICollectionViewCell {
    let imageView = UIImageView(image: #imageLiteral(resourceName: "phone_backspace"))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        imageView.contentMode = .scaleAspectFit
        addSubview(imageView)
        imageView.centerInSuperview(size: .init(width: 40, height: 40))
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = frame.width / 2
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
