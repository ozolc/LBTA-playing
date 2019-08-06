//
//  EpisodeCell.swift
//  PodcastsCourseLBTA
//
//  Created by Maksim Nosov on 06/08/2019.
//  Copyright © 2019 Maksim Nosov. All rights reserved.
//

import UIKit

class EpisodeCell: UITableViewCell {
    
    var episode: Episode! {
        didSet {
            titleLabel.text = episode.title
            descriptionLabel.text = episode.description
            
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd MMM yyyy"
            pubDateLabel.text = dateFormatter.string(from: episode.pubDate)
        }
    }
    
    @IBOutlet weak var episodeImageView: UIImageView!
    @IBOutlet weak var pubDateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.numberOfLines = 2
        }
    }
    @IBOutlet weak var descriptionLabel: UILabel! {
        didSet {
            descriptionLabel.numberOfLines = 2
        }
    }
    
    
}
