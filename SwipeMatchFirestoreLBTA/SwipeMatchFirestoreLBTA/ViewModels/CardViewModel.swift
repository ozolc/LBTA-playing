//
//  CardViewModel.swift
//  SwipeMatchFirestoreLBTA
//
//  Created by Maksim Nosov on 25/07/2019.
//  Copyright © 2019 Maksim Nosov. All rights reserved.
//

import UIKit

protocol ProducesCardViewModel {
    func toCardViewModel() -> CardViewModel
}

struct CardViewModel {
    // we'll define the properties that are view will display/render out
    let imageNames: [String]
    let attributedString: NSAttributedString
    let textAlignment: NSTextAlignment
}
