//
//  AppGroup.swift
//  AppStoreJSONApis
//
//  Created by Maksim Nosov on 13/05/2019.
//  Copyright © 2019 Maksim Nosov. All rights reserved.
//

import Foundation

struct AppGroup: Decodable {
    let feed: Feed
    
}

struct Feed: Decodable {
    let title: String
    let results: [FeedResult]
}

struct FeedResult: Decodable {
    let name, artistName, artworkUrl100: String
}
