//
//  UIView+Style.swift
//  Dreamer
//
//  Created by Justin Rose on 5/10/18.
//  Copyright © 2018 justncode LLC. All rights reserved.
//

import UIKit

extension UIView {
    func round(cornerRadius: CGFloat) {
        layer.cornerRadius = cornerRadius
        clipsToBounds = true
    }
}
