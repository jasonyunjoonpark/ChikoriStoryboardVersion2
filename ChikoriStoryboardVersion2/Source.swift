//
//  Source.swift
//  ChikoriStoryboardVersion2
//
//  Created by Jason Park on 3/15/18.
//  Copyright © 2018 Jason Park. All rights reserved.
//

import Foundation
import Spotify

class Source: NSObject {
    
    static let si = Source()
    fileprivate override init() {}
    
    var auth = SPTAuth.defaultInstance()!
    var session: SPTSession!
    var spotifyPlayer: SPTAudioStreamingController!
}
