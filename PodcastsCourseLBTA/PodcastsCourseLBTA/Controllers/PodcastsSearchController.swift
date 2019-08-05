//
//  PodcastsSearchController.swift
//  PodcastsCourseLBTA
//
//  Created by Maksim Nosov on 05/08/2019.
//  Copyright © 2019 Maksim Nosov. All rights reserved.
//

import UIKit

class PodcastsSearchController: UITableViewController, UISearchBarDelegate {
    
    let podcasts = [
        Podcast(name: "Lets Build That App", artistName: "Brian Voong"),
        Podcast(name: "Some Podcast", artistName: "Some Author"),
    ]
    
    let cellId = "cellId"
    
    // lets implement a UISearchController
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupSearchBar()
        setupTableView()
    }
    
    //MARK: - Setup Work
    
    fileprivate func setupSearchBar() {
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
        // later implement Alamofire to search iTunes API
    }
    
    fileprivate func setupTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
    }
    
    // MARK: - UITableView
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return podcasts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        
        let podcast = podcasts[indexPath.row]
        cell.textLabel?.text = "\(podcast.name)\n\(podcast.artistName)"
        cell.textLabel?.numberOfLines = 0
        cell.imageView?.image = #imageLiteral(resourceName: "appicon")
        
        return cell
    }
    
}
