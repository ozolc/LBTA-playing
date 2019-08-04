//
//  RecentMessageCell.swift
//  SwipeMatchFirestoreLBTA
//
//  Created by Maksim Nosov on 04/08/2019.
//  Copyright © 2019 Maksim Nosov. All rights reserved.
//

import LBTATools

class RecentMessageCell: LBTAListCell<UIColor> {
    
    let userProfileImageView = UIImageView(image: #imageLiteral(resourceName: "jane3.jpg"), contentMode: .scaleAspectFill)
    let usernameLabel = UILabel(text: "USERNAME HERE", font: .boldSystemFont(ofSize: 18))
    let messageTextLabel =  UILabel(text: "Some long line of text that should span 2 lines.", font: .systemFont(ofSize: 16), textColor: .darkGray, numberOfLines: 2)
    
    override var item: UIColor! {
        didSet {
//            backgroundColor = item
        }
    }
    
    override func setupViews() {
        super.setupViews()
        
        userProfileImageView.layer.cornerRadius = 94 / 2
        
        hstack(userProfileImageView.withWidth(94).withHeight(94),
               stack(usernameLabel, messageTextLabel, spacing: 2),
               spacing: 20,
               alignment: .center
            ).padLeft(20).padRight(20)
        
        addSeparatorView(leadingAnchor: usernameLabel.leadingAnchor)
    }
}

