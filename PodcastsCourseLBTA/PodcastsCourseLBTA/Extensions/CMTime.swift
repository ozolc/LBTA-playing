//
//  CMTime.swift
//  PodcastsCourseLBTA
//
//  Created by Maksim Nosov on 07/08/2019.
//  Copyright © 2019 Maksim Nosov. All rights reserved.
//

import AVKit

extension CMTime {
    
    func toDisplayString() -> String {
        let totalSeconds = Int(CMTimeGetSeconds(self))
        let seconds = totalSeconds % 60
        let minutes = totalSeconds / 60
        let timeFormatString = String(format: "%02d:%02d", minutes, seconds)
        return timeFormatString
    }
    
}
