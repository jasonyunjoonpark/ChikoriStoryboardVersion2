//
//  SpotifyLoginController.swift
//  ChikoriStoryboardVersion2
//
//  Created by Jason Park on 3/15/18.
//  Copyright © 2018 Jason Park. All rights reserved.
//

import UIKit
import Spotify
import SafariServices

class SpotifyLoginController: UIViewController {
    
    var player: SPTAudioStreamingController?
    var loginURL: URL?
    var sfSafariViewController: SFSafariViewController?
    
    func setupSpotify() {
        SPTAuth.defaultInstance().clientID = "493df9756d314c87b58e8c817c9f74f8"
        SPTAuth.defaultInstance().redirectURL = URL(string: "chikoristoryboardversion2://returnafterlogin")
        SPTAuth.defaultInstance().requestedScopes = [SPTAuthStreamingScope,
                                                     SPTAuthPlaylistReadPrivateScope,
                                                     SPTAuthPlaylistModifyPublicScope,
                                                     SPTAuthPlaylistModifyPrivateScope]
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        setupSpotify()
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(SpotifyLoginController.updateAfterLogin),
                                               name: Notification.Name(rawValue: "loginSuccessful"),
                                               object: nil)
        
        if UserDefaults.standard.data(forKey: "SpotifySession") != nil {
            updateAfterLogin()
        }

    }


    @IBAction func spotifyLoginButtonPressed(_ sender: Any) {
        let appUrl = SPTAuth.defaultInstance().spotifyAppAuthenticationURL()!
        let webUrl = SPTAuth.defaultInstance().spotifyWebAuthenticationURL()!
        
        //Check to see if the user has Spotify installed
        if SPTAuth.supportsApplicationAuthentication() {
            //Open: Spotify app by opening its url
            UIApplication.shared.open(appUrl, options: [:], completionHandler: nil)
        } else {
            //Setup & Open: sfSafariViewController if Spotify app is not installed
            sfSafariViewController = SFSafariViewController(url: webUrl)
            present(sfSafariViewController!, animated: true, completion: nil)
        }
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "segueToSearchController" {
//            let searchController = segue.destination as? SearchController
//            searchController?.session = Source.si.session
//        }
//    }
    
    @objc func updateAfterLogin() {
        if let sessionObj: AnyObject = UserDefaults().object(forKey: "SpotifySession") as AnyObject? {
            let sessionDataObj = sessionObj as! Data
            NSKeyedArchiver.setClassName("SPTSession", for: SPTSession.self)
            NSKeyedUnarchiver.setClass(SPTSession.self, forClassName: "SPTSession")
            let firstTimeSession = NSKeyedUnarchiver.unarchiveObject(with: sessionDataObj) as! SPTSession
            Source.si.session = firstTimeSession
            spotifyLoginSuccessful()
            
        }
    }
    
    
    func spotifyLoginSuccessful() {
        DispatchQueue.main.async {
            self.dismiss(animated: (self.sfSafariViewController != nil), completion: nil)
            
            NotificationCenter.default.post(name: Notification.Name(rawValue: "updateSearchController"), object: nil)
        }
        
        //if login successful update SearchController and ProfileController
    }
        
        
        
}
















