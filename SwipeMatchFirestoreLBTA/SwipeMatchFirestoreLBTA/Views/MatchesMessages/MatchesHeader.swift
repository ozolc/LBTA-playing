//
//  MatchesHeader.swift
//  SwipeMatchFirestoreLBTA
//
//  Created by Maksim Nosov on 04/08/2019.
//  Copyright © 2019 Maksim Nosov. All rights reserved.
//

import LBTATools

class MatchesHeader: UICollectionReusableView {
    
    let newMatchesLabel = UILabel(text: "New Matches", font: .boldSystemFont(ofSize: 18), textColor: #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1))
    let matchesHorizontalController = MatchesHorizontalController()
    let messagesLabel = UILabel(text: "Messages", font: .boldSystemFont(ofSize: 18), textColor: #colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1))
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        stack(stack(newMatchesLabel).padLeft(20),
              matchesHorizontalController.view,
              stack(messagesLabel).padLeft(20),
              spacing: 20).withMargins(.init(top: 20, left: 0, bottom: 8, right: 0))
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
}

struct Match {
    let name, profileImageUrl, uid: String
    
    init(dictionary: [String: Any]) {
        self.name = dictionary["name"] as? String ?? ""
        self.profileImageUrl = dictionary["profileImageUrl"] as? String ?? ""
        self.uid = dictionary["uid"] as? String ?? ""
    }
}
