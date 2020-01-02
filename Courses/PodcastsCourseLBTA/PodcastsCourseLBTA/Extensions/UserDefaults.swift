//
//  UserDefaults.swift
//  PodcastsCourseLBTA
//
//  Created by Maksim Nosov on 09/08/2019.
//  Copyright © 2019 Maksim Nosov. All rights reserved.
//

import Foundation

extension UserDefaults {
    
    static let favoritedPodcastKey = "favoritePodcastKey"
    static let downloadedEpisodesKey = "downloadedEpisodesKey"
    
    func downloadEpisode(episode: Episode) {
        do {
            var episodes = downloadedEpisodes()
//            episodes.append(episode)
            episodes.insert(episode, at: 0)
            let data = try JSONEncoder().encode(episodes)
            UserDefaults.standard.set(data, forKey: UserDefaults.downloadedEpisodesKey)
        } catch let encodeErr {
            print("Failed to encode episode:", encodeErr)
        }
    }
    
    func downloadedEpisodes() -> [Episode] {
        guard let episodeData = data(forKey: UserDefaults.downloadedEpisodesKey) else { return [] }
        
        do {
            let episodes = try JSONDecoder().decode([Episode].self, from: episodeData)
            return episodes
        } catch let decodeErr {
            print("Failed to decode:", decodeErr)
        }
        
        return []
    }
    
    func savedPodcasts() -> [Podcast] {
        guard let savedPodcastsData = UserDefaults.standard.data(forKey: UserDefaults.favoritedPodcastKey) else { return [] }
        guard let savedPodcasts = try?  NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(savedPodcastsData) as? [Podcast] else { return [] }
        return savedPodcasts
    }
    
    func deletePodcast(podcast: Podcast) {
        let podcasts = savedPodcasts()
        let filteredPodcasts = podcasts.filter { (p) -> Bool in
            return p.trackName != podcast.trackName && p.artistName != podcast.artistName
        }
        guard let data = try? NSKeyedArchiver.archivedData(withRootObject: filteredPodcasts, requiringSecureCoding: false) else { return }
        UserDefaults.standard.set(data, forKey: UserDefaults.favoritedPodcastKey)
    }
    
    func deleteEpisode(episode: Episode) {
        let savedEpisodes = downloadedEpisodes()
        let filteredEpisodes = savedEpisodes.filter { (e) -> Bool in
            return e.title != episode.title && e.author != episode.author
        }
        
        do {
            let data = try JSONEncoder().encode(filteredEpisodes)
            UserDefaults.standard.set(data, forKey: UserDefaults.downloadedEpisodesKey)
        } catch let decodeErr {
            print("Failed to encode downloaded episodes:", decodeErr)
        }
    }
    
}
