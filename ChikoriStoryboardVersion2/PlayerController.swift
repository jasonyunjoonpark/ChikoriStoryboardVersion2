//
//  PlayerController.swift
//  ChikoriStoryboardVersion2
//
//  Created by Jason Park on 3/15/18.
//  Copyright © 2018 Jason Park. All rights reserved.
//

import UIKit
import AVFoundation
import Spotify

class PlayerController: UIViewController {
    
    var albumImage = UIImage()
    var songTitle = String()
    var songURI = String()
    
    @IBOutlet weak var titleLabel: UINavigationItem!
    @IBOutlet var backgroundImageView: UIImageView!
    @IBOutlet var mainImageView: UIImageView!
//    @IBOutlet var songTitleLabel: UILabel!
    @IBOutlet var playPauseButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.title = songTitle
        backgroundImageView.image = albumImage
        mainImageView.image = albumImage
        playSongWith(uri: songURI)
    }
    
    func playSongWith(uri: String) {
        Source.si.spotifyPlayer.playSpotifyURI(songURI, startingWith: 0, startingWithPosition: 0) { (error) in
            if error != nil {
                print("Error: \(error!.localizedDescription)")
            }
        }
    }
    
    @IBAction func playPause(_ sender: UIButton) {
        if Source.si.spotifyPlayer.playbackState != nil {
            if Source.si.spotifyPlayer.playbackState.isPlaying {
                Source.si.spotifyPlayer.setIsPlaying(false, callback: nil)
                playPauseButton.setTitle("🎶", for: .normal)
            } else {
                Source.si.spotifyPlayer.setIsPlaying(true, callback: nil)
                playPauseButton.setTitle("🤭", for: .normal)
            }
        }
    }
    
}
