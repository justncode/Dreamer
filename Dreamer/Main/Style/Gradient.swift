//
//  Gradient.swift
//  Dreamer
//
//  Created by Justin Rose on 5/10/18.
//  Copyright © 2018 justncode LLC. All rights reserved.
//

import UIKit

struct Gradient {
    static var gradient: CAGradientLayer!
    
    static func mask(colors: [UIColor], locations: [CGFloat], to view: UIView)  {
        gradient = CAGradientLayer()
        gradient.frame = view.bounds
        gradient.colors = colors.map { $0.cgColor }
        gradient.locations = locations as [NSNumber]
        view.layer.mask = gradient
    }
    
    static func updateFrame(to rect: CGRect) {
        gradient.frame = rect
    }
}
