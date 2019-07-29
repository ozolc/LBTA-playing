//
//  RegistrationViewModel.swift
//  SwipeMatchFirestoreLBTA
//
//  Created by Maksim Nosov on 28/07/2019.
//  Copyright © 2019 Maksim Nosov. All rights reserved.
//

import UIKit
import Firebase

class RegistrationViewModel {
    
    var bindableRegistering = Bindable<Bool>()
    var bindableImage = Bindable<UIImage>()
    var bindableIsFormValid = Bindable<Bool>()
    
    var fullName: String? {
        didSet {
            checkFormVaidity()
        }
    }
    var email: String? { didSet { checkFormVaidity() } }
    var password: String? { didSet { checkFormVaidity() } }
    
    func performRegistration(completion: @escaping (Error?) -> ()) {
        guard let email = email, let password = password else { return }
        self.bindableRegistering.value = true
        Auth.auth().createUser(withEmail: email, password: password) { (res, err) in
            
            if let err = err {
                completion(err)
                return
            }
            
            print("Successfully registered user:", res?.user.uid ?? "")
            
            // Only upload images to Firebase Storage once you are authorized
            let filename = UUID().uuidString
            let ref = Storage.storage().reference(withPath: "/images/\(filename)")
            let imageData = self.bindableImage.value?.jpegData(compressionQuality: 0.75) ?? Data()
            ref.putData(imageData, metadata: nil, completion: { (_, err) in
                
                if let err = err {
                    completion(err)
                    return // bail
                }
                
                print("Finished uploading image to storage")
                ref.downloadURL(completion: { (url, err) in
                    if let err = err {
                        completion(err)
                        return
                    }
                    
                    self.bindableRegistering.value = false
                    print("Download url of our image is:", url?.absoluteString ?? "")
                    
                })
            })
        }
    }
    
    fileprivate func checkFormVaidity() {
        let isFormValid = fullName?.isEmpty == false && email?.isEmpty == false && password?.isEmpty == false
        bindableIsFormValid.value = isFormValid
    }
    
    
    
}
