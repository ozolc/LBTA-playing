//
//  CreateCompanyController.swift
//  IntermediateTraining
//
//  Created by Maksim Nosov on 09/09/2019.
//  Copyright © 2019 Maksim Nosov. All rights reserved.
//

import UIKit

class CreateCompanyController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Create Company"
        
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(handleCancel))
        
        view.backgroundColor = .darkBlue
    }
    
    @objc fileprivate func handleCancel() {
        dismiss(animated: true, completion: nil)
    }
    
}
