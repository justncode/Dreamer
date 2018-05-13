//
//  UIViewController+Keyboard.swift
//  Dreamer
//
//  Created by Justin Rose on 5/13/18.
//  Copyright © 2018 justncode LLC. All rights reserved.
//

import UIKit

extension UIViewController {
    func hideKeyboardWhenTapped() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}
