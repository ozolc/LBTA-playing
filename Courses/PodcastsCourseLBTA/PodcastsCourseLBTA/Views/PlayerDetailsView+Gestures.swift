//
//  PlayerDetailsView+Gestures.swift
//  PodcastsCourseLBTA
//
//  Created by Maksim Nosov on 08/08/2019.
//  Copyright © 2019 Maksim Nosov. All rights reserved.
//

import UIKit

extension PlayerDetailsView {
    @objc func handlePan(gesture: UIPanGestureRecognizer) {
        if gesture.state == .changed {
            handlePanChange(gesture: gesture)
        } else if gesture.state == .ended {
            handlePanEnded(gesture: gesture)
        }
    }
    
    fileprivate func handlePanChange(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: self.superview)
        self.transform = CGAffineTransform(translationX: 0, y: translation.y)
        
        self.miniPlayerView.alpha = 1 + translation.y / 200
        self.maximizedStackView.alpha = -translation.y / 200
    }
    
    fileprivate func handlePanEnded(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: self.superview)
        let velocity = gesture.velocity(in: self.superview)
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.transform = .identity
            
            if translation.y < -200 || velocity.y < -500 {
                let mainTabBarController = UIApplication.mainTabBarController()
                mainTabBarController?.maximizePlayerDetails(episode: nil)
            } else {
                self.miniPlayerView.alpha = 1
                self.maximizedStackView.alpha = 0
            }
        })
    }
    
    @objc func handleTapMaximize() {
        let mainTabBarController = UIApplication.mainTabBarController()
        mainTabBarController?.maximizePlayerDetails(episode: nil)
    }
}
