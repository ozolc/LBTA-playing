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
    func fetchApps(completion: @escaping ([Result], Error?) -> ()) {
        
        let urlString = "https://itunes.apple.com/search?term=instagram&entity=software"
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
    
}
