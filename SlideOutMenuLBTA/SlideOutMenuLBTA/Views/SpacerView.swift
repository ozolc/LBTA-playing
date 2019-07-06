//
//  SpacerView.swift
//  SlideOutMenuLBTA
//
//  Created by Maksim Nosov on 06/07/2019.
//  Copyright © 2019 Maksim Nosov. All rights reserved.
//

import UIKit

class SpacerView: UIView {

    let space: CGFloat
    
    override var intrinsicContentSize: CGSize {
        return .init(width: space, height: space)
    }
    
    init(space: CGFloat) {
        self.space = space
        super.init(frame: .zero)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
