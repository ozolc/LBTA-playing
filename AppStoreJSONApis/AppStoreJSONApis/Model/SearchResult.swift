//
//  SearchResult.swift
//  AppStoreJSONApis
//
//  Created by Maksim Nosov on 14/07/2019.
//  Copyright © 2019 Maksim Nosov. All rights reserved.
//

import Foundation

struct SearchResult: Decodable {
    let resultCount: Int
    let results: [Result]
}

struct Result: Decodable {
    let trackId: Int
    let trackName: String
    let primaryGenreName: String
    let averageUserRating: Float?
    var screenshotUrls: [String]?
    let artworkUrl100: String
    let formattedPrice: String?
    let description: String?
    var releaseNotes: String?
    var artistName: String?
    var collectionName: String?
}
