//
//  Bindable.swift
//  SwipeMatchFirestoreLBTA
//
//  Created by Maksim Nosov on 29/07/2019.
//  Copyright © 2019 Maksim Nosov. All rights reserved.
//

import Foundation

class Bindable<T> {
    var value: T? {
        didSet {
            observer?(value)
        }
    }
    
    var observer: ((T?)->())?
    
    func bind(observer: @escaping (T?) ->()) {
        self.observer = observer
    }
    
}
