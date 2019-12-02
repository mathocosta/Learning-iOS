//
//  DialogPresentationController.swift
//  CustomTransitions
//
//  Created by Matheus Oliveira Costa on 01/12/19.
//  Copyright © 2019 mathocosta. All rights reserved.
//

import UIKit

public class DialogPresentationController: UIPresentationController {
    private let dimmingView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(white: 0.0, alpha: 0.5)
        view.alpha = 0.0

        return view
    }()

    private lazy var tapGesture: UITapGestureRecognizer = {
        return UITapGestureRecognizer(target: self, action: #selector(handleTap(_:)))
    }()

    override public var frameOfPresentedViewInContainerView: CGRect {
        let presentedSize = size(forChildContentContainer: presentedViewController,
                                  withParentContainerSize: containerView!.bounds.size)

        var frame: CGRect = .zero
        frame.size = presentedSize
        frame.origin.x = containerView!.center.x - (presentedSize.width / 2)
        frame.origin.y = containerView!.center.y - (presentedSize.height / 2)

        return frame
    }

    override public func size(
        forChildContentContainer container: UIContentContainer, withParentContainerSize parentSize: CGSize) -> CGSize {
        return CGSize(width: parentSize.width * 0.9, height: parentSize.height * 0.7)
    }

    public override func containerViewDidLayoutSubviews() {
        super.containerViewDidLayoutSubviews()
        presentedView?.frame = frameOfPresentedViewInContainerView

        presentedView?.layer.cornerRadius = 20
        presentedView?.layer.masksToBounds = true

        dimmingView.addGestureRecognizer(tapGesture)
    }

    public override func presentationTransitionWillBegin() {
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

    public override func dismissalTransitionWillBegin() {
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

    @objc func handleTap(_ gestureRecognizer: UITapGestureRecognizer) {
        presentedViewController.dismiss(animated: true)
    }

}
