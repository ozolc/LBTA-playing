//
//  Message.swift
//  SwipeMatchFirestoreLBTA
//
//  Created by Maksim Nosov on 04/08/2019.
//  Copyright © 2019 Maksim Nosov. All rights reserved.
//

import FirebaseFirestore
import FirebaseAuth

struct Message {
    let text, fromId, toId: String
    let timestamp: Timestamp
    let isFromCurrentLoggedUser: Bool
    
    init(dictionary: [String: Any]) {
        self.text = dictionary["text"] as? String ?? ""
        self.fromId = dictionary["fromId"] as? String ?? ""
        self.toId = dictionary["toId"] as? String ?? ""
        self.timestamp = dictionary["timestamp"] as? Timestamp ?? Timestamp(date: Date())
        
        self.isFromCurrentLoggedUser = Auth.auth().currentUser?.uid == self.fromId
    }
}
