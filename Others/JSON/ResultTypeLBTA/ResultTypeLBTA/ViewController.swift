//
//  ViewController.swift
//  ResultTypeLBTA
//
//  Created by Maksim Nosov on 03/04/2019.
//  Copyright © 2019 Maksim Nosov. All rights reserved.
//

import UIKit

struct Course: Decodable {
    let id: Int
    let name: String
    let imageUrl: String
    let number_of_lessons: Int
}

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchCourseJSONwithResult { (res) in
            switch res {
            case .success(let courses):
                courses.forEach({ (course) in
                    print(course.name)
                })
            case .failure(let err):
                print("Failed to fetch courses", err)
            }
        }
    
        //        fetchCourseJSONwithResult { (courses, err) in
        //            // ambiguous situation here
        //
        //
        //            if let err = err {
        //                print("Failed to fetch courses", err)
        //                return
        //            }
        //
        //            courses?.forEach({ (course) in
        //                print(course.name)
        //            })
        //        }
    }
}

fileprivate func fetchCourseJSONwithResult(completion: @escaping (Result<[Course], Error>) ->()){
    
    let urlString = "https://api.letsbuildthatapp.com/jsondecodable/courses"
    guard let url = URL(string: urlString) else { return }
    
    URLSession.shared.dataTask(with: url) { (data, resp, err) in
        
        if let err = err {
            completion(.failure(err))
            return
        }
        
        // successful
        guard let data = data else { return }
        do {
            let courses = try JSONDecoder().decode([Course].self, from: data)
            completion(.success(courses))
            //                completion(courses, nil)
            
        } catch let jsonError {
            completion(.failure(jsonError))
            //                completion(nil, jsonError)
        }
        
        }.resume()
}




fileprivate func fetchCourseJSON(completion: @escaping ([Course]? ,Error?) ->()){
    
    let urlString = "https://api.letsbuildthatapp.com/jsondecodable/courses"
    guard let url = URL(string: urlString) else { return }
    
    URLSession.shared.dataTask(with: url) { (data, resp, err) in
        
        if let err = err {
            completion(nil, err)
            return
        }
        
        // successful
        guard let data = data else { return }
        do {
            let courses = try JSONDecoder().decode([Course].self, from: data)
            completion(courses, nil)
            
        } catch let jsonError {
            completion(nil, jsonError)
        }
        
        }.resume()
}


