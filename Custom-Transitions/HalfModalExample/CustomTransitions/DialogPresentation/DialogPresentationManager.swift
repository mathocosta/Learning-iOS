//
//  DialogPresentationManager.swift
//  CustomTransitions
//
//  Created by Matheus Oliveira Costa on 01/12/19.
//  Copyright © 2019 mathocosta. All rights reserved.
//

import UIKit

public class DialogPresentationManager: NSObject {

}

extension DialogPresentationManager: UIViewControllerTransitioningDelegate {
    public func presentationController(
        forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController
    ) -> UIPresentationController? {
        return DialogPresentationController(presentedViewController: presented, presenting: presenting)
    }
}
