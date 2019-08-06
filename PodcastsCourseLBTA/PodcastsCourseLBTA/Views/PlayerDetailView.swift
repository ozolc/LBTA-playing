//
//  PlayerDetailView.swift
//  PodcastsCourseLBTA
//
//  Created by Maksim Nosov on 06/08/2019.
//  Copyright © 2019 Maksim Nosov. All rights reserved.
//

import UIKit

class PlayerDetailView: UIView {
    
    var episode: Episode! {
        didSet {
            titleLabel.text = episode.title
            authorLabel.text = episode.author
            
            guard let url = URL(string: episode.imageUrl ?? "") else { return }
            episodeImageView.sd_setImage(with: url)
        }
    }
    
    @IBOutlet weak var playPauseButton: UIButton!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var episodeImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel! {
        didSet {
            titleLabel.numberOfLines = 2
        }
    }
    
    @IBAction func handleDismiss(_ sender: Any) {
        self.removeFromSuperview()
    }
    
    
}
