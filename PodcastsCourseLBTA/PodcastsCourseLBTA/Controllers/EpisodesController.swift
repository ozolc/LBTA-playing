//
//  EpisodesController.swift
//  PodcastsCourseLBTA
//
//  Created by Maksim Nosov on 06/08/2019.
//  Copyright © 2019 Maksim Nosov. All rights reserved.
//

import UIKit
import FeedKit

class EpisodesController: UITableViewController {
    
    var podcast: Podcast? {
        didSet {
            navigationItem.title = podcast?.trackName
            
            fetchEpisode()
        }
    }
    
    fileprivate func fetchEpisode() {
        guard let feedUrl = podcast?.feedUrl else { return }
        
        APIService.shared.fetchEpisode(feedUrl: feedUrl) { (episodes) in
            self.episodes = episodes
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    fileprivate let cellId = "cellId"
    
    var episodes = [Episode]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setupNavigationBarButtons()
    }
    
    //MARK: - Setup work
    fileprivate func setupNavigationBarButtons() {
        navigationItem.rightBarButtonItems = [
            UIBarButtonItem(title: "Favorite", style: .plain, target: self, action: #selector(handleFavorite)),
            UIBarButtonItem(title: "Fetch", style: .plain, target: self, action: #selector(handleFetchSavedPodcasts))
        ]
    }
    
    let favoritePodcastKey = "favoritePodcastKey"
    
    @objc fileprivate func handleFetchSavedPodcasts() {
        print("Fetching saved Podcasts from UserDefaults")
        let value = UserDefaults.standard.value(forKey: favoritePodcastKey) as? String
        print(value ?? "")
        
        // how to retrieve our Podcast object from UserDefaults
        guard let data = UserDefaults.standard.data(forKey: favoritePodcastKey) else { return }
        let podcast = NSKeyedUnarchiver.unarchiveObject(with: data) as? Podcast
        print(podcast?.trackName, podcast?.artistName)
    }
    
    @objc fileprivate func handleFavorite() {
        print("Saving info into UserDefaults")
        
        guard let podcast = self.podcast else { return }
        
        // 1. Transform Podcast into Data
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: podcast, requiringSecureCoding: false)
        UserDefaults.standard.set(data, forKey: favoritePodcastKey)
        } catch let err {
            print("Failed to archive Podcast into Data with error:", err)
        }
        
        
    }
    
    fileprivate func setupTableView() {
        let nib = UINib(nibName: "EpisodeCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: cellId)
        tableView.tableFooterView = UIView()
    }
    
    //MARK: - UITableView
    
    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let activityIndicatorView = UIActivityIndicatorView(style: .whiteLarge)
        activityIndicatorView.color = .darkGray
        activityIndicatorView.startAnimating()
        return activityIndicatorView
    }
    
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return episodes.isEmpty ? 200 : 0
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let episode = self.episodes[indexPath.row]
        
        let mainTabBarController = UIApplication.mainTabBarController()
        mainTabBarController?.maximizePlayerDetails(episode: episode, playlistEpisodes: self.episodes)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return episodes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! EpisodeCell
        let episode = episodes[indexPath.row]
        
        cell.episode = episode
        cell.podcastArtworkUrl = podcast?.artworkUrl600
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 134
    }
    
}
