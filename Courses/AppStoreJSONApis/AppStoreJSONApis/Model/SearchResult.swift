//
//  SearchResult.swift
//  AppStoreJSONApis
//
//  Created by Maksim Nosov on 12.02.2020.
//  Copyright © 2020 Maksim Nosov. All rights reserved.
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
    let screenshotUrls: [String]
    let artworkUrl100: String
    let formattedPrice: String?
    let description: String
    let releaseNotes: String?
}
