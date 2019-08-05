//
//  APIService.swift
//  PodcastsCourseLBTA
//
//  Created by Maksim Nosov on 05/08/2019.
//  Copyright © 2019 Maksim Nosov. All rights reserved.
//

import Foundation
import Alamofire

class APIService {
    
    let baseItunesSearchURL = "https://itunes.apple.com/search"
    
    // singleton
    static let shared = APIService()
    
    func fetchPodcasts(searchText: String, completionHandler: @escaping ([Podcast]) -> ()) {
        print("Searching for podcasts...")
        
        
        let parameters = ["term": searchText, "media": "podcast"]
        
        AF.request(baseItunesSearchURL, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: nil).response { (dataResponse) in
            if let err = dataResponse.error {
                print("Failed to contact \(self.baseItunesSearchURL)", err)
                return
            }
            
            guard let data = dataResponse.data else { return }
            do {
                let searchResult = try JSONDecoder().decode(SearchResults.self, from: data)
                completionHandler(searchResult.results)
            } catch let decodeErr {
                print("Failed to decode:", decodeErr)
            }
        }

    }
    
}

struct SearchResults: Decodable {
    let resultCount: Int
    let results: [Podcast]
}
