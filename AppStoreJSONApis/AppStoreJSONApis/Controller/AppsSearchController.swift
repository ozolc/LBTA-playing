//
//  AppsSearchController.swift
//  AppStoreJSONApis
//
//  Created by Maksim Nosov on 21/04/2019.
//  Copyright © 2019 Maksim Nosov. All rights reserved.
//

import UIKit
import SDWebImage

class AppsSearchController: UICollectionViewController, UICollectionViewDelegateFlowLayout, UISearchBarDelegate {
    
    // Идентификатор для пересоздаваемой ячейки в методе cellForItemAt. Значение произвольное - не имеет смысла.
    fileprivate let cellId = "id1234"
    
    // SearchController который будем находится в NavigationBar как NavigationItem
    fileprivate let searchController = UISearchController(searchResultsController: nil)
    
    // Подсказка пользователю, отображаемая при пустом экране (начальный экран без результата поиска)
    fileprivate let enterSearchTermLabel: UILabel = {
        let label = UILabel()
        label.text = "Please enter search term above..."
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.backgroundColor = .white
        
        // Регистрируем класс (указать Class.self) для использования при создании ячейки CollectionView (обязательно регистрировать!!!)
        collectionView.register(SearchResultCell.self, forCellWithReuseIdentifier: cellId)
        
        // Добавлен как subview для collectionView, чтобы надпись двигалась при фокусировке и расфокусировки строки поиска.
        collectionView.addSubview(enterSearchTermLabel)
        enterSearchTermLabel.fillSuperview(padding: .init(top: 100, left: 50, bottom: 0, right: 50))
        
        setupSearchBar()
        
//        fetchITunesApps()
    }
    
    // Настройка строки поиска в NavigationBar
    fileprivate func setupSearchBar() {
        // для разрешения наложения при презентации нового ViewController (случай при фокусировки строки с поиском)
        definesPresentationContext = true
        navigationItem.searchController = self.searchController
        navigationItem.hidesSearchBarWhenScrolling = false // Отобразить SearchBar при загрузке. По-умолчанию отображается при скроллинге.
        searchController.dimsBackgroundDuringPresentation = false // отключение затемнения при фокусировки строки с поиском
        searchController.searchBar.delegate = self // назначить делегатом SearchController этот класс (AppsSearchController подписали под протокол UISearchBarDelegate). При возникновении событий - логика переопределяется.
    }
    
    var timer: Timer? // таймер для задержки поиска
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        timer?.invalidate() // остановка таймера и удаление его из RunLoop
        // Задержка (throttling) перед выполнением поиска
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { _ in
            Service.shared.fetchApps(searchTerm: searchText) { (res, err) in
                self.appResults = res
                DispatchQueue.main.async {
                    self.collectionView.reloadData()
                }
            }
        }) // окончание блока Timer
        
    }
    
    // Локальный массив с полученными данными из JSON (trackName, primaryGenreName)
    // Используется для datasource CollectionView
    fileprivate var appResults = [Result]()
    
    fileprivate func fetchITunesApps() {
        
        Service.shared.fetchApps(searchTerm: "Twitter") { (results, err) in
            
            if let err = err {
                print("Failed to fetch apps:", err)
                return
            }
            
            self.appResults = results
            // На случай если есть проблемы с Интернет и мы не можем получить данные, обновим collectionView
            // Обновление UI только в main потоке
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    // В этом методе мы переопределяем размер ячейки (метод из протокола UICollectionViewDelegateFlowLayout)
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return .init(width: view.frame.width, height: 350)
    }
    
    // Указываем количество ячеек в секции
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        enterSearchTermLabel.isHidden = appResults.count != 0 // Если количество Item в CollectionView не равно 0 - надпись с подсказкой о поиске НЕ ОТОБРАЖАЕТСЯ
        return appResults.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SearchResultCell
        cell.appResult = appResults[indexPath.item]
        
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
