//
//  CustomTabBarController.swift
//  Dreamer
//
//  Created by Justin Rose on 5/9/18.
//  Copyright © 2018 justncode LLC. All rights reserved.
//

import UIKit

class CustomTabBarController: UITabBarController {
    
    let entryStore = EntryStore()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    // MARK: - Interface Setup
    private func setupViews() {
        setupTabBar()
    }
    
    private func setupTabBarViews() {
        let calendarsController = CalendarsController()
        calendarsController.entryStore = entryStore
        let calendarsNavController = UINavigationController(rootViewController: calendarsController)
        calendarsNavController.tabBarItem.image = #imageLiteral(resourceName: "history")
        
        let entriesController = EntriesController()
        entriesController.entryStore = entryStore
        let entriesNavController = UINavigationController(rootViewController: entriesController)
        entriesNavController.tabBarItem.image = #imageLiteral(resourceName: "entries")
        
        viewControllers = [calendarsNavController, entriesNavController]
    }
    
    private func setupTabBar() {
        tabBar.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        tabBar.unselectedItemTintColor = #colorLiteral(red: 0.9999960065, green: 1, blue: 1, alpha: 0.5)
        tabBar.isTranslucent = true
        tabBar.backgroundImage = UIImage()
        tabBar.backgroundColor = .clear
        
        setupTabBarViews()
    }
}
