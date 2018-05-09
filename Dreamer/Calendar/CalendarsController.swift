//
//  CalendarsController.swift
//  Dreamer
//
//  Created by Justin Rose on 5/9/18.
//  Copyright © 2018 justncode LLC. All rights reserved.
//

import UIKit

class CalendarsController: UIViewController {
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    // MARK: - Interface Setup
    private func setupViews() {
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "Dreamer"
    }
}
