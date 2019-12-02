//
//  HalfModalDismissAnimationController.swift
//  CustomTransitions
//
//  Created by Matheus Oliveira Costa on 30/11/19.
//  Copyright © 2019 mathocosta. All rights reserved.
//

import UIKit

public class HalfModalDismissAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    public func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.6
    }

    public func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromVC = transitionContext.viewController(forKey: .from) else { return }

        let presentedFrame = transitionContext.finalFrame(for: fromVC)
        var dismissedFrame = presentedFrame
        dismissedFrame.origin.y = transitionContext.containerView.frame.size.height

        let animationDuration = transitionDuration(using: transitionContext)
        fromVC.view.frame = presentedFrame
        UIView.animate(withDuration: animationDuration, animations: {
            fromVC.view.frame = dismissedFrame
        }, completion: { finished in
            fromVC.view.removeFromSuperview()
            transitionContext.completeTransition(finished)
        })
    }
}
