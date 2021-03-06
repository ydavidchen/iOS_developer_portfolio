//  AppDelegate.swift
//  MemeMe version 2.0
//  Created by DavidKevinChen on 4/4/20
//  Copyright © 2020 DavidKevinChen. All rights reserved.

import UIKit;

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    //MARK: Objects for saving memes
    var memes = [Meme](); //initialise for the very first time?
    
    //MARK: - Built-in methods
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        return true
    }
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role);
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {}
}

