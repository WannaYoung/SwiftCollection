//
//  AppDelegate.swift
//  SwiftCollection
//
//  Created by 王洋 on 2019/2/1.
//  Copyright © 2019 wannayoung. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window?.rootViewController = TabBarController()
        if window?.traitCollection.forceTouchCapability == .available {
            setup3DTouch(app: application)
        }
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        
    }

    func applicationWillTerminate(_ application: UIApplication) {
        
    }

    func application(_ application: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        
    }
    
    func setup3DTouch(app: UIApplication) {
        let alarmItem = UIApplicationShortcutItem(type: "alarm", localizedTitle: "闹钟", localizedSubtitle: nil, icon: UIApplicationShortcutIcon(type: .alarm), userInfo: nil)
        let favoriteItem = UIApplicationShortcutItem(type: "favorite", localizedTitle: "收藏", localizedSubtitle: nil, icon: UIApplicationShortcutIcon(type: .favorite), userInfo: nil)
        app.shortcutItems = [alarmItem, favoriteItem]
    }

}

