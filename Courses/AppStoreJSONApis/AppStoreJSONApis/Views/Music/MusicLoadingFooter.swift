//
//  MusicLoadingFooter.swift
//  AppStoreJSONApis
//
//  Created by Maksim Nosov on 28.02.2020.
//  Copyright © 2020 Maksim Nosov. All rights reserved.
//

import UIKit

class MusicLoadingFooter: UICollectionReusableView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let aiv = UIActivityIndicatorView(style: .large)
        aiv.color = .darkGray
        aiv.startAnimating()
        
        let label = UILabel(text: "Loading more...", font: .systemFont(ofSize: 16))
        label.textAlignment = .center
        
        let stackView = VerticalStackView(arrangedSubviews: [
            label, aiv
        ], spacing: 8)
        
        addSubview(stackView)
        stackView.centerInSuperview(size: .init(width: 200, height: 0))
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
