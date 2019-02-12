//
//  NavigationAnimator.swift
//  Dreamer
//
//  Created by Justin Rose on 5/10/18.
//  Copyright © 2018 justncode LLC. All rights reserved.
//

import UIKit

class NavigationAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    var duration: TimeInterval
    var operation: UINavigationController.Operation
    
    init(_ operation: UINavigationController.Operation = .push, _ duration: TimeInterval = 0.5) {
        self.duration = duration
        self.operation = operation
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromView = transitionContext.view(forKey: .from),
            let toView = transitionContext.view(forKey: .to),
            operation != .none else { return }
        
        let containerView = transitionContext.containerView
        
        operation == .push ? containerView.addSubview(toView) : containerView.insertSubview(toView, belowSubview: fromView)
        let multiplier: CGFloat = operation == .push ? 1 : -1
        toView.frame = CGRect(x: multiplier * toView.bounds.width, y: 0, width: toView.bounds.width, height: toView.bounds.height)
        
        UIView.animate(withDuration: duration, animations: {
            toView.frame = CGRect(x: 0, y: 0, width: toView.bounds.width, height: toView.bounds.height)
            fromView.frame = CGRect(x: -multiplier * fromView.bounds.width, y: 0, width: toView.bounds.width, height: toView.bounds.height)
        }) { _ in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
    }
}
