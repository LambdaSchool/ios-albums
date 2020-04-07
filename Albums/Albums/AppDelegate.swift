//
//  AppDelegate.swift
//  Albums
//
//  Created by Jon Bash on 2019-12-02.
//  Copyright © 2019 Jon Bash. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        /*
        // test data
        let albumController = AlbumController()
        
        do {
            let album = try albumController.testDecodingExampleAlbum()
            print(album.artist, " - ", album.name, album.songs.map { "\($0.name) - \($0.duration)" })
            print("art: \(album.coverArtURLs)")
            
            let albumJSONData = try albumController.testEncodingExampleAlbum(album)
            if let albumJSONString = String(data: albumJSONData, encoding: .utf8) {
                print(albumJSONString)
            }
        } catch {
            print("error decoding example album: \(error)")
        }
        */
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

