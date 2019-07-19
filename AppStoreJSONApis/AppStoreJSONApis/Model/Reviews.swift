//
//  Reviews.swift
//  AppStoreJSONApis
//
//  Created by Maksim Nosov on 18/07/2019.
//  Copyright © 2019 Maksim Nosov. All rights reserved.
//

import Foundation

struct Reviews: Decodable {
    let feed: ReviewFeed
}

struct ReviewFeed: Decodable {
    let entry: [Entry]
}

struct Entry: Decodable {
    let author: Author
    let title: Label
    let content: Label
}

struct Author: Decodable {
    let name: Label
}

struct Label: Decodable{
    let label: String
}
