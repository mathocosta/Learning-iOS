//
//  ViewController.swift
//  HalfModalExample
//
//  Created by Matheus Oliveira Costa on 30/11/19.
//  Copyright © 2019 mathocosta. All rights reserved.
//

import UIKit
import CustomTransitions

class ViewController: UIViewController {

    lazy var halfModalPresentation = HalfModalPresentationManager(modalHeight: .medium)
    lazy var dialogPresentation = DialogPresentationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetails", let destinationController = segue.destination as? DetailsViewController {

            guard let presentationStyle = sender as? String else { return }

            switch presentationStyle {
            case "HalfModal":
                destinationController.transitioningDelegate = halfModalPresentation
                destinationController.modalPresentationStyle = .custom
            case "DialogModal":
                destinationController.transitioningDelegate = dialogPresentation
                destinationController.modalPresentationStyle = .custom
            default: break
            }

        }
    }

    @IBAction func presentHalfModalAction(_ sender: UIButton) {
        performSegue(withIdentifier: "ShowDetails", sender: "HalfModal")
    }

    @IBAction func presentDialogAction(_ sender: UIButton) {
        performSegue(withIdentifier: "ShowDetails", sender: "DialogModal")
    }
}

