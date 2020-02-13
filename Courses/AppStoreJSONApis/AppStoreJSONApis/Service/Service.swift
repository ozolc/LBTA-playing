//
//  Service.swift
//  AppStoreJSONApis
//
//  Created by Maksim Nosov on 13.02.2020.
//  Copyright © 2020 Maksim Nosov. All rights reserved.
//

import Foundation

class Service {
    
    static let shared = Service()
    
    func fetchApps(searchTerm: String, completion: @escaping ([Result], Error?) -> ()) {
        let urlString = "https://itunes.apple.com/search?term=\(searchTerm)&entity=software"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            
            if let err = err {
                print("Failed to fetch apps:", err)
                completion([], nil)
                return
            }
            
            // success
            guard let data = data else { return }
            
            do {
                let searchResult = try JSONDecoder().decode(SearchResult.self, from: data)
                
                completion(searchResult.results, nil)
                
            } catch (let jsonErr) {
                print("Failed to decode json:", jsonErr)
                completion([], jsonErr)
            }
            
        }.resume()
    }
    
    func fetchGames(completion: @escaping (AppGroup?, Error?) -> ()) {
        guard let url = URL(string: "https://rss.itunes.apple.com/api/v1/us/ios-apps/new-games-we-love/all/50/explicit.json") else { return }
        
        URLSession.shared.dataTask(with: url) { (data, resp, err) in
            
            if let err = err {
                completion(nil, err)
                return
            }
            
            do {
                let appGroup = try JSONDecoder().decode(AppGroup.self, from: data!)
                // success
                appGroup.feed.results.forEach({ print(($0.name)) })
                completion(appGroup, nil)
            } catch {
                completion(nil, error)
//                print("Failed to decode:", error)
            }
            
        }.resume()
    }
    
}
