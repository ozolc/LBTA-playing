//
//  RegistrationViewModel.swift
//  SwipeMatchFirestoreLBTA
//
//  Created by Maksim Nosov on 28/07/2019.
//  Copyright © 2019 Maksim Nosov. All rights reserved.
//

import UIKit

class RegistrationViewModel {
    
    var bindableImage = Bindable<UIImage>()
    var bindableIsFormValid = Bindable<Bool>()
    
    var fullName: String? {
        didSet {
            checkFormVaidity()
        }
    }
    var email: String? { didSet { checkFormVaidity() } }
    var password: String? { didSet { checkFormVaidity() } }
    
    fileprivate func checkFormVaidity() {
        let isFormValid = fullName?.isEmpty == false && email?.isEmpty == false && password?.isEmpty == false
        bindableIsFormValid.value = isFormValid
    }
    
    
    
}
