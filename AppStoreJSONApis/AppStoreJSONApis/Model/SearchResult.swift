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
    let trackName: String
    let primaryGenreName: String
    let averageUserRating: Float?
}
