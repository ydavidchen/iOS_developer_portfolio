//  SceneDelegate.swift
//  MemeMe version 2.0
//  Created by DavidKevinChen on 4/4/20
//  Copyright © 2020 DavidKevinChen. All rights reserved.

import UIKit;

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?;
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let _ = (scene as? UIWindowScene) else { return }
    }
    func sceneDidDisconnect(_ scene: UIScene){}
    func sceneDidBecomeActive(_ scene: UIScene){}
    func sceneWillResignActive(_ scene: UIScene){}
    func sceneWillEnterForeground(_ scene: UIScene){}
    func sceneDidEnterBackground(_ scene: UIScene){}
}

