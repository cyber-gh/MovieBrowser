//
//  AppDelegate.swift
//  MovieBrowser
//
//  Created by soltan on 31/10/2019.
//  Copyright © 2019 personal. All rights reserved.
//

import UIKit


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {



    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        window = UIWindow()
        window?.makeKeyAndVisible()
        
     
        
        let baseController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()!
        window?.rootViewController = baseController
        
        return true
    }

    // This method will be called when app received push notifications in foreground
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .badge, .sound])
    }



}
