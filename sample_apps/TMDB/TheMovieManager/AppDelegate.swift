//  AppDelegate.swift
//  TheMovieManager
//  Created by Owen LaRosa on 8/13/18.
//  Copyright © 2018 Udacity. All rights reserved.

import UIKit;

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    // MARK: - System properties
    var window: UIWindow?;
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {return true;}
    func applicationWillResignActive(_ application: UIApplication) {}
    func applicationDidEnterBackground(_ application: UIApplication) {}
    func applicationWillEnterForeground(_ application: UIApplication) {}
    func applicationDidBecomeActive(_ application: UIApplication) {}
    func applicationWillTerminate(_ application: UIApplication) {}
    
    // MARK: - Handle external login below
    func application(_ app:UIApplication, open url:URL, options:[UIApplication.OpenURLOptionsKey:Any]=[:]) -> Bool {
        let components = URLComponents(url:url, resolvingAgainstBaseURL:true);
        if components?.scheme == "themoviemanager" && components?.path == "authenticate" {
            let loginVC = window?.rootViewController as! LoginViewController;
            TMDBClient.createSessionId(completion:loginVC.handleSessionResponse(success:error:));
        }
        return true;
    }
    
}

