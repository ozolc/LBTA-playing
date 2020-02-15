//
//  AppGroup.swift
//  AppStoreJSONApis
//
//  Created by Maksim Nosov on 13.02.2020.
//  Copyright © 2020 Maksim Nosov. All rights reserved.
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
    let id, name, artistName, artworkUrl100: String
    
}
