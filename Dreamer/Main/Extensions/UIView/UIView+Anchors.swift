//
//  UIView+Anchors.swift
//  Dreamer
//
//  Created by Justin Rose on 5/9/18.
//  Copyright © 2018 justncode LLC. All rights reserved.
//

import UIKit

extension UIView {
    func center() {
        translatesAutoresizingMaskIntoConstraints = false
        guard let superview = superview else { return }
        centerXAnchor.constraint(equalTo: superview.centerXAnchor).isActive = true
        centerYAnchor.constraint(equalTo: superview.centerYAnchor).isActive = true
    }
    
    func centerWithConstant(x: CGFloat = 0, y: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        guard let superview = superview else { return }
        centerXAnchor.constraint(equalTo: superview.centerXAnchor, constant: x).isActive = true
        centerYAnchor.constraint(equalTo: superview.centerYAnchor, constant: y).isActive = true
    }
    
    func centerX(to anchor: NSLayoutXAxisAnchor, constant: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        centerXAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
    }
    
    func centerY(to anchor: NSLayoutYAxisAnchor, constant: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        centerYAnchor.constraint(equalTo: anchor, constant: constant).isActive = true
    }
    
    func anchor(top: NSLayoutYAxisAnchor? = nil, leading: NSLayoutXAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, trailing: NSLayoutXAxisAnchor? = nil) {
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            topAnchor.constraint(equalTo: top).isActive = true
        }
        
        if let leading = leading {
            leadingAnchor.constraint(equalTo: leading).isActive = true
        }
        
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom).isActive = true
        }
        
        if let trailing = trailing {
            trailingAnchor.constraint(equalTo: trailing).isActive = true
        }
    }
    
    func anchor(top: (anchor: NSLayoutYAxisAnchor, constant: CGFloat)? = nil,
                leading: (anchor: NSLayoutXAxisAnchor, constant: CGFloat)? = nil,
                bottom: (anchor: NSLayoutYAxisAnchor, constant: CGFloat)? = nil,
                trailing: (anchor: NSLayoutXAxisAnchor, constant: CGFloat)? = nil) {
        
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            topAnchor.constraint(equalTo: top.anchor, constant: top.constant).isActive = true
        }
        
        if let leading = leading {
            leadingAnchor.constraint(equalTo: leading.anchor, constant: leading.constant).isActive = true
        }
        
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom.anchor, constant: bottom.constant).isActive = true
        }
        
        if let trailing = trailing {
            trailingAnchor.constraint(equalTo: trailing.anchor, constant: trailing.constant).isActive = true
        }
    }
}
