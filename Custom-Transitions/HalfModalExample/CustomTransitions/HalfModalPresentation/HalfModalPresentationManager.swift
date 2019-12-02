//
//  HalfModalPresentationManager.swift
//  CustomTransitions
//
//  Created by Matheus Oliveira Costa on 30/11/19.
//  Copyright © 2019 mathocosta. All rights reserved.
//

import UIKit

public class HalfModalPresentationManager: NSObject {
    private let modalHeight: HalfModalHeight
    private var interactionController: HalfModalInteractionController?

    public init(modalHeight: HalfModalHeight = .medium) {
        self.modalHeight = modalHeight
    }
}

extension HalfModalPresentationManager: UIViewControllerTransitioningDelegate {
    public func presentationController(
        forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController
    ) -> UIPresentationController? {
        let presentationController = HalfModalPresentationController(
          presentedViewController: presented, presenting: presenting, height: modalHeight)

        interactionController = HalfModalInteractionController(viewController: presented)

        return presentationController
    }

    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return HalfModalDismissAnimationController()
    }

    public func interactionControllerForDismissal(
        using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactionController
    }
}
