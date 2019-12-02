//
//  HalfModalPresentationController.swift
//  CustomTransitions
//
//  Created by Matheus Oliveira Costa on 30/11/19.
//  Copyright © 2019 mathocosta. All rights reserved.
//

import UIKit

public enum HalfModalHeight {
    case large, medium, small

    var heightMultiplier: CGFloat {
        switch self {
        case .large: return 0.8
        case .medium: return 0.6
        case .small: return 0.4
        }
    }

    var originY: CGFloat {
        return 1 - heightMultiplier
    }
}

public class HalfModalPresentationController: UIPresentationController {
    var modalHeight: HalfModalHeight

    private let dimmingView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(white: 0.0, alpha: 0.5)
        view.alpha = 0.0

        return view
    }()

    override public var frameOfPresentedViewInContainerView: CGRect {
        var frame: CGRect = .zero
        frame.size = size(forChildContentContainer: presentedViewController,
                          withParentContainerSize: containerView!.bounds.size)

        frame.origin.y = containerView!.frame.height * modalHeight.originY

        return frame
    }

    public init(
        presentedViewController: UIViewController,
        presenting presentingViewController: UIViewController?,
        height: HalfModalHeight
    ) {
        self.modalHeight = height
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)

        let recognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap(recognizer:)))
        dimmingView.addGestureRecognizer(recognizer)
    }

    override public func containerViewDidLayoutSubviews() {
        super.containerViewDidLayoutSubviews()
        presentedView?.frame = frameOfPresentedViewInContainerView

        let maskPath = UIBezierPath(
            roundedRect: presentedView!.bounds,
            byRoundingCorners: [.topLeft, .topRight],
            cornerRadii: CGSize(width: 25.0, height: 25.0)
        )
        let shape = CAShapeLayer()
        shape.path = maskPath.cgPath
        presentedView?.layer.mask = shape
    }

    override public func size(
        forChildContentContainer container: UIContentContainer, withParentContainerSize parentSize: CGSize) -> CGSize {
        return CGSize(width: parentSize.width, height: parentSize.height * modalHeight.heightMultiplier)
    }

    override public func presentationTransitionWillBegin() {
        containerView?.insertSubview(dimmingView, at: 0)

        NSLayoutConstraint.activate(
            NSLayoutConstraint.constraints(
                withVisualFormat: "V:|[dimmingView]|", options: [], metrics: nil, views: ["dimmingView": dimmingView]))

        NSLayoutConstraint.activate(
            NSLayoutConstraint.constraints(
                withVisualFormat: "H:|[dimmingView]|", options: [], metrics: nil, views: ["dimmingView": dimmingView]))

        guard let coordinator = presentedViewController.transitionCoordinator else {
            dimmingView.alpha = 1.0
            return
        }

        coordinator.animate(alongsideTransition: { _ in
            self.dimmingView.alpha = 1.0
        })
    }

    override public func dismissalTransitionWillBegin() {
        guard let coordinator = presentedViewController.transitionCoordinator else {
            dimmingView.alpha = 0.0
            return
        }

        coordinator.animate(alongsideTransition: { _ in
            self.dimmingView.alpha = 0.0
        }) { _ in
            self.dimmingView.removeFromSuperview()
        }
    }

    @objc func handleTap(recognizer: UITapGestureRecognizer) {
        presentedViewController.dismiss(animated: true)
    }

}
