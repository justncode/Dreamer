//
//  UILabel+Initialization.swift
//  Dreamer
//
//  Created by Justin Rose on 5/10/18.
//  Copyright © 2018 justncode LLC. All rights reserved.
//

import UIKit

extension UILabel {
    convenience init(text: String? = nil,
                     textColor: UIColor! = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1),
                     font: UIFont! = .systemFont(ofSize: 12),
                     textAlignment: NSTextAlignment = .left,
                     numberOfLines: Int = 1) {
        self.init()
        self.text = text
        self.textColor = textColor
        self.font = font
        self.textAlignment = textAlignment
        self.numberOfLines = numberOfLines
    }
}
