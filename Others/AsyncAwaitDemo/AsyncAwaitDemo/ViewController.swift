//
//  ViewController.swift
//  AsyncAwaitDemo
//
//  Created by Maksim Nosov on 23/04/2019.
//  Copyright © 2019 Maksim Nosov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // example of callback hell
        
//        fetchSomething { (d, r, e) in
//            self.fetchSomething(completion: { (d2, r2, e2) in
//                self.fetchSomething(completion: { (d3, r3, e3) in
//                    print("Finally completed my fetches")
//                })
//            })
//        }
        
        // async-await
//        do {
//            fetchSomething()
//        } catch err {
//            print("Failed to fetch something1")
//            return
//        }
//
//        do {
//            fetchSomething()
//        } catch err {
//            print("Failed to fetch something2")
//            return
//        }
//
//        do {
//            fetchSomething()
//        } catch err {
//            print("Failed to fetch something3")
//        }
        
        do {
            let data = try fetchSomethingAsyncAwait()
            let s = String(decoding: data!, as: UTF8.self)
            print("Data:", s)
        } catch {
            print("Failed to fetch stuff:", error)
        }
    }
    
    enum NetworkError: Error {
        case url
        case statusCode
        case standardError
    }
    
    // async await fetch function
    func fetchSomethingAsyncAwait() throws -> Data? {
        guard let dummyURL = URL(string: "https://www.google.com") else {
            throw NetworkError.url
        }
        
        var data: Data?
        var response: URLResponse?
        var error: Error?
        
        // Semaphore
        let semaphore = DispatchSemaphore(value: 0)
        
        URLSession.shared.dataTask(with: dummyURL) { (d, r, e) in
            data = d
            response = r
            error = e
            
            semaphore.signal()
        }.resume()
        
        _ = semaphore.wait(timeout: .distantFuture)
        
        if let httpURLResponse = response as? HTTPURLResponse,
            httpURLResponse.statusCode > 300 {
            throw NetworkError.statusCode
        }
        
        if error != nil {
            throw NetworkError.standardError
        }
        
        return data
    }
    // callback hell
    func fetchSomething(completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        guard let dummyURL = URL(string: "https://www.google.com") else { return }
        
        URLSession.shared.dataTask(with: dummyURL) { (data, res, err) in
            completion(data, res, err)
        }.resume()
    }


}

