//
//  ViewController.swift
//  KindleLBTA
//
//  Created by Maksim Nosov on 21/03/2019.
//  Copyright © 2019 Maksim Nosov. All rights reserved.
//

import UIKit

class Book {
    let title: String
    let author: String
    let pages: [Page]
    
    init(title: String, author: String, pages: [Page]) {
        self.title = title
        self.author = author
        self.pages = pages
    }
}

class Page {
    let number: Int
    let text: String
    
    init(number: Int, text: String) {
        self.number = number
        self.text = text
    }
}

class ViewController: UIViewController {
    
    var books: [Book]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .red
        // can provide custom code starting here
        
        setupBooks()        
    }
    
    func setupBooks() {
        let page1 = Page(number: 1, text: "Text for the first page")
        let page2 = Page(number: 2, text: "Text for the second page")
        
        let pages = [page1, page2]
        
        let book = Book(title: "Steve Jobs", author: "Walter Isaacson", pages: pages)
        
        let book2 = Book(title: "Bill Gates: A Biography", author: "Michael Becraft", pages: [
            Page(number: 1, text: "Text for page 1"),
            Page(number: 2, text: "Text for page 2"),
            Page(number: 3, text: "Text for page 3"),
            Page(number: 4, text: "Text for page 4")
            ])
        
        self.books = [book, book2]
        
        guard let books = self.books else { return }
        
        //        for book in books {
        //            print(book.title)
        //            for page in book.pages {
        //                print(page.text)
        //            }
        //        }
        
        if let unwrappedBooks = self.books {
            for book in unwrappedBooks {
                print(book.title)
                for page in book.pages {
                    print(page.text)
                }
            }
        }
    }
    
}

