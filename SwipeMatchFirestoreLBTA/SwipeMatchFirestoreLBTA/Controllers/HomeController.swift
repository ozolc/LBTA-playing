//
//  ViewController.swift
//  SwipeMatchFirestoreLBTA
//
//  Created by Maksim Nosov on 24/07/2019.
//  Copyright © 2019 Maksim Nosov. All rights reserved.
//

import UIKit

class HomeController: UIViewController {

    let topStackView = TopNavigationStackView()
    let buttonStackView = HomeBottomControlsStackView()
    let cardsDeckView = UIView()
    
//    let users = [
//        User(name: "Kelly", age: 23, profession: "Music DJ", imageName: "lady5c"),
//        User(name: "Jane", age: 18, profession: "Teacher", imageName: "lady4c")
//    ]
    
    let cardViewModels = [
        User(name: "Kelly", age: 23, profession: "Music DJ", imageName: "lady5c").toCardViewModel(),
        User(name: "Jane", age: 18, profession: "Teacher", imageName: "lady4c").toCardViewModel()
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        setupDummyCards()
        
    }
    
    // MARK: - Fileprivate
    
    fileprivate func setupDummyCards() {
        cardViewModels.forEach { (cardVM) in
            let cardView = CardView(frame: .zero)
            cardView.imageView.image = UIImage(named: cardVM.imageName)
            cardView.informationLabel.attributedText = cardVM.attributedString
            cardView.informationLabel.textAlignment = cardVM.textAlignment
            
            cardsDeckView.addSubview(cardView)
            cardView.fillSuperview()
        }
        
//        users.forEach { (user) in
//            let cardView = CardView(frame: .zero)
//            cardView.imageView.image = UIImage(named: user.imageName)
//
//            let attributedText = NSMutableAttributedString(string: user.name, attributes: [.font: UIFont.systemFont(ofSize: 32, weight: .heavy)])
//            attributedText.append(NSAttributedString(string: " \(user.age)", attributes: [.font: UIFont.systemFont(ofSize: 24, weight: .regular)]))
//            attributedText.append(NSAttributedString(string: "\n\(user.profession)", attributes: [.font: UIFont.systemFont(ofSize: 20, weight: .regular)]))
//
//            cardView.informationLabel.attributedText = attributedText
//
//            cardsDeckView.addSubview(cardView)
//            cardView.fillSuperview()
//        }
    }

    fileprivate func setupLayout() {
        let overallStackView = UIStackView(arrangedSubviews: [topStackView, cardsDeckView, buttonStackView])
        overallStackView.axis = .vertical
        view.addSubview(overallStackView)
        overallStackView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.trailingAnchor)
        overallStackView.isLayoutMarginsRelativeArrangement = true
        overallStackView.layoutMargins = .init(top: 0, left: 12, bottom: 0, right: 12)
        
        overallStackView.bringSubviewToFront(cardsDeckView)
    }

}

