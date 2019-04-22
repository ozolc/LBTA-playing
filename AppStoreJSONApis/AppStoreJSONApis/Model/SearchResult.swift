//
//  SearchResult.swift
//  AppStoreJSONApis
//
//  Created by Maksim Nosov on 22/04/2019.
//  Copyright © 2019 Maksim Nosov. All rights reserved.
//

import Foundation

// Структуры для полученных данных из JSON
struct SearchResult: Decodable {
    let resultCount: Int
    let results: [Result]
}

struct Result: Decodable {
    let trackName: String
    let primaryGenreName: String
    var averageUserRating: Float?
    let screenshotUrls: [String] // app screnshots 
    let artworkUrl100: String // app icon
}
