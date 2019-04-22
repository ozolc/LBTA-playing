//
//  AppsSearchController.swift
//  AppStoreJSONApis
//
//  Created by Maksim Nosov on 21/04/2019.
//  Copyright © 2019 Maksim Nosov. All rights reserved.
//

import UIKit

class AppsSearchController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    // Идентификатор для пересоздаваемой ячейки в методе cellForItemAt. Значение произвольное - не имеет смысла.
    fileprivate let cellId = "id1234"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
        
        // Регистрируем класс (указать Class.self) для использования при создании ячейки CollectionView (обязательно регистрировать!!!)
        collectionView.register(SearchResultCell.self, forCellWithReuseIdentifier: cellId)
        
        fetchITunesApps()
    }
    
    fileprivate func fetchITunesApps() {
        let urlString = "https://itunes.apple.com/search?term=instagram&entity=software"
        guard let url = URL(string: urlString) else { return }
        
        // Получение данных из Интернет
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            
            // Проверка на получение ошибки при загрузки из Интернет. Если ошибка - выход из метода.
            if let err = err {
                print("Failed to fetch apps:", err)
                return
            }
            
            // Успех загрузки
            
            guard let data = data else { return }
            
            // Пытаемся произвести декодирование из JSON в объект структуры SearchResult.
            do {
                let searchResult = try JSONDecoder().decode(SearchResult.self, from: data)
                
                searchResult.results.forEach { print($0.trackName, $0.primaryGenreName) }
                
            } catch let jsonErr {
                print("Failed to decode json:", jsonErr)
            }
            
        }.resume() // Запустить получение данных из URL. Иначе загрузка не будет произведена.
    }
    
    // В этом методе мы переопределяем размер ячейки (метод из протокола UICollectionViewDelegateFlowLayout)
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 350)
    }
    
    // Указываем количество ячеек в секции
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SearchResultCell
        cell.nameLabel.text = "Here is my app name"
        return cell
    }
    
    init() {
        //  Вызываем родительский инициализатор с обязательным!!! параметром Layout. Тем самым не указываем параметр collectionViewLayout при создании в BaseTabBarController
        super.init(collectionViewLayout: UICollectionViewFlowLayout())
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
