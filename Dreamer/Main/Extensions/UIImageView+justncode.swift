//
//  UIImageView+justncode.swift
//  Dreamer
//
//  Created by Conner Maddalozzo on 6/5/22.
//  Copyright © 2022 justncode LLC. All rights reserved.
//

import UIKit

extension UIImageView {
    func JNCStyled() {
        layer.borderWidth = 5
        isUserInteractionEnabled = true
        layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.33).cgColor
        backgroundColor = #colorLiteral(red: 0.9305578581, green: 0.9305578581, blue: 0.9305578581, alpha: 0.5)
        tintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.8)
    }
}
