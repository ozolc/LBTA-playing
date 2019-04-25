//
//  Extensions.swift
//  AppStoreJSONApis
//
//  Created by Maksim Nosov on 25/04/2019.
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

// Расширение для создание convenience инициализатора UIImageView с закругленными краями.
extension UIImageView {
    convenience init(cornerRadius: CGFloat) {
        self.init(image: nil)
        self.layer.cornerRadius = cornerRadius
        self.clipsToBounds = true
        self.contentMode = .scaleAspectFill
    }
}

// Расширение UIButton с convenience инициализатором.
extension UIButton {
    convenience init(title: String) {
        self.init(type: .system)
        self.setTitle(title, for: .normal)
    }
}

