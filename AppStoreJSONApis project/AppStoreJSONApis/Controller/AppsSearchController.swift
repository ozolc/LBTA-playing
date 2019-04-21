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
        
        // Регистрируем класс (указать Class.self) для использования при создании но ячейки CollectionView (обязательно регистрировать!!!)
        collectionView.register(SearchResultCell.self, forCellWithReuseIdentifier: cellId)
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
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        
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
