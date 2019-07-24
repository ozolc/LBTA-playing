//
//  ViewController.swift
//  SwipeMatchFirestoreLBTA
//
//  Created by Maksim Nosov on 24/07/2019.
//  Copyright © 2019 Maksim Nosov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let topStackView = TopNavigationStackView()
    let buttonStackView = HomeBottomControlsStackView()
    let blueView = UIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        blueView.backgroundColor = .blue
        setupLayout()
    }
    
    // MARK: - Fileprivate

    fileprivate func setupLayout() {
        let overallStackView = UIStackView(arrangedSubviews: [topStackView, blueView, buttonStackView])
        overallStackView.axis = .vertical
        
        view.addSubview(overallStackView)
        overallStackView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor)
    }

}

