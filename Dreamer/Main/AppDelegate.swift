//
//  AppDelegate.swift
//  Dreamer
//
//  Created by Justin Rose on 5/9/18.
//  Copyright © 2018 justncode LLC. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        UINavigationBar.appearance().tintColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 0.5)
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedString.Key.foregroundColor:#colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.5)]
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().isTranslucent = true
        
        window = UIWindow()
        window?.rootViewController = CustomTabBarController()
        window?.makeKeyAndVisible()
        
        return true
    }
}

