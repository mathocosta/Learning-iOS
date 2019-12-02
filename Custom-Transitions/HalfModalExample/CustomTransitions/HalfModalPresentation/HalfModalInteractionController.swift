//
//  HalfModalInteractionController.swift
//  CustomTransitions
//
//  Created by Matheus Oliveira Costa on 30/11/19.
//  Copyright © 2019 mathocosta. All rights reserved.
//

import UIKit

public class HalfModalInteractionController: UIPercentDrivenInteractiveTransition {
    private var interactionInProgress: Bool = false
    private var shouldCompleteTransition = false {
        didSet { print(shouldCompleteTransition) }
    }
    private weak var viewController: UIViewController?

    lazy var gestureRecognizer: UIPanGestureRecognizer = {
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(handle(_:)))
        return gesture
    }()

    public init(viewController: UIViewController?) {
        self.viewController = viewController
        super.init()

        viewController?.view.addGestureRecognizer(gestureRecognizer)
    }

    @objc func handle(_ gestureRecognizer: UIPanGestureRecognizer) {
        guard let gestureRecognizerView = gestureRecognizer.view?.superview else { return }
        let translation = gestureRecognizer.translation(in: gestureRecognizerView)
        let verticalMovement = translation.y / gestureRecognizerView.bounds.height

        switch gestureRecognizer.state {
        case .began:
            interactionInProgress = true
            viewController?.dismiss(animated: true, completion: nil)
        case .changed:
            shouldCompleteTransition = verticalMovement > 0.5
            update(verticalMovement)
        case .cancelled:
            interactionInProgress = false
            cancel()
        case .ended:
            interactionInProgress = false
            if shouldCompleteTransition {
                finish()
            } else {
                cancel()
            }
        default: break
        }

    }
}
