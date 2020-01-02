//
//  ChatroomMenuContainerController.swift
//  SlideOutMenuLBTA
//
//  Created by Maksim Nosov on 09/07/2019.
//  Copyright © 2019 Maksim Nosov. All rights reserved.
//

import UIKit

class ChatroomMenuContainerController: UIViewController {
    
    let chatroomsMenuController = ChatroomsMenuController()
    
    let searchContainer = SearchContainerView()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = #colorLiteral(red: 0.2980392157, green: 0.2078431373, blue: 0.2862745098, alpha: 1)
        
        let chatroomsView = chatroomsMenuController.view!
        view.addSubview(chatroomsView)
        
        searchContainer.searchBar.delegate = chatroomsMenuController
        
        view.addSubview(searchContainer)
        searchContainer.backgroundColor = #colorLiteral(red: 0.2571061171, green: 0.2078431373, blue: 0.2862745098, alpha: 1)
        
        searchContainer.anchor(top: view.topAnchor, leading: view.leadingAnchor, bottom: nil, trailing: view.trailingAnchor)
        searchContainer.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 64).isActive = true
        
        chatroomsView.anchor(top: searchContainer.bottomAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.bottomAnchor, trailing: view.trailingAnchor)
    }
    
}

class SearchContainerView: UIView {
    
    let searchBar: UISearchBar = {
        let sb = UISearchBar()
        sb.searchBarStyle = .minimal
        sb.placeholder = "Enter some filter"
        return sb
    }()
    
    let rocketImageView: UIImageView = {
        let iv = UIImageView(image: #imageLiteral(resourceName: "rocket"))
        iv.contentMode = .scaleAspectFit
        iv.layer.cornerRadius = 5
        iv.clipsToBounds = true
        return iv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).textColor = .white
        
        addSubview(searchBar)
        addSubview(rocketImageView)
        
        rocketImageView.anchor(top: nil, leading: safeAreaLayoutGuide.leadingAnchor, bottom: bottomAnchor, trailing: nil, padding: .init(top: 0, left: 10, bottom: 10, right: 0), size: .init(width: 44, height: 44))
        
        searchBar.anchor(top: nil, leading: rocketImageView.trailingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 0, bottom: 4, right: 0))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}
