//
//  ViewController.swift
//  KindleLBTA
//
//  Created by Maksim Nosov on 21/03/2019.
//  Copyright © 2019 Maksim Nosov. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var books: [Book]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(BookCell.self, forCellReuseIdentifier: "cellId")
        tableView.tableFooterView = UIView()
        navigationItem.title = "Kindle"
        
        setupBooks()
        fetchBook()
    }
    
    func fetchBook() {
        print("Fetching book....")
        if let url = URL(string: "https://letsbuildthatapp-videos.s3-us-west-2.amazonaws.com/kindle.json") {
            URLSession.shared.dataTask(with: url) { (data, response, error) in
                
                if let err = error {
                    print("Failed to fetch external json books: ", err)
                    return
                }
                
//                print(response)
                
//                print(data)
                
                guard let dataX = data else { return }
                
                guard let dataAsString = String(data: dataX, encoding: .utf8) else { return }
                print(dataAsString)
                
            }.resume()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let selectedBook = self.books?[indexPath.row]
//        print(selectedBook?.title)
//        return
        
        let layout = UICollectionViewFlowLayout()
        let bookPageController = BookPageController(collectionViewLayout: layout)
        
        bookPageController.book = selectedBook
        
        let navController = UINavigationController(rootViewController: bookPageController)
        present(navController, animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 86
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath) as! BookCell
        
        let book = books?[indexPath.row]
        cell.book = book
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = books?.count {
            return count
        }
        return 0
    }
    
    func setupBooks() {
        let page1 = Page(number: 1, text: "Text for the first page")
        let page2 = Page(number: 2, text: "Text for the second page")
        
        let pages = [page1, page2]
        
        let book = Book(title: "Steve Jobs", author: "Walter Isaacson", image: #imageLiteral(resourceName: "steve_jobs"), pages: pages)
        
        let book2 = Book(title: "Bill Gates: A Biography", author: "Michael Becraft", image: #imageLiteral(resourceName: "bill_gates"), pages: [
            Page(number: 1, text: "Text for page 1"),
            Page(number: 2, text: "Text for page 2"),
            Page(number: 3, text: "Text for page 3"),
            Page(number: 4, text: "Text for page 4")
            ])
        
        self.books = [book, book2]
    }
    
}

