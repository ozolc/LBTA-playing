//
//  Service.swift
//  AppStoreJSONApis
//
//  Created by Maksim Nosov on 22/04/2019.
//  Copyright © 2019 Maksim Nosov. All rights reserved.
//

import Foundation

class Service {
    
    static let shared = Service() // Singleton
    private init() {}
    
    // Метод для получения данных из Интернет.
    // Возвращает completion с массивом [Result] и ошибкой
    func fetchApps(searchTerm: String, completion: @escaping ([Result], Error?) -> ()) {
        
        let urlString = "https://itunes.apple.com/search?term=\(searchTerm)&entity=software"
        guard let url = URL(string: urlString) else { return }
        
        // Получение данных из Интернет
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            
            // Проверка на получение ошибки при загрузки из Интернет. Если ошибка - выход из метода.
            if let err = err {
                print("Failed to fetch apps:", err)
                completion([], nil) // возврат escaping замыкания в случае ошибки
                return
            }
            
            // Успех загрузки
            
            guard let data = data else { return }
            
            // Пытаемся произвести декодирование из JSON в объект структуры SearchResult.
            do {
                let searchResult = try JSONDecoder().decode(SearchResult.self, from: data)
                
                // Возвращаем результат "results" через closure completion() с параметром @escaping, чтобы получить к нему доступ через "results in { }"
                completion(searchResult.results, nil) 
                
            } catch let jsonErr {
                print("Failed to decode json:", jsonErr)
                completion([], jsonErr) // возврат escaping замыкания в случае ошибки
            }
            
            }.resume() // Запустить получение данных из URL. Иначе загрузка не будет произведена.
    }
    
    func fetchGames(completion: @escaping (AppGroup?, Error?) -> ()) {
        let urlString = "https://rss.itunes.apple.com/api/v1/us/ios-apps/new-games-we-love/all/50/explicit.json"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, url, err) in
            
//            print(String(data: data!, encoding: .utf8))
            
            if let err = err {
                completion(nil, err)
                return
            }
            
            do {
                let appGroup = try JSONDecoder().decode(AppGroup.self, from: data!)
                // success
                completion(appGroup, nil)
            } catch {
                completion(nil, error)
//                print("Failed to decode:", error)
            }
            
            
        }.resume()
    }
    
}
