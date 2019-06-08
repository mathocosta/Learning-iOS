//
//  ViewController.swift
//  LearnCoordinator
//
//  Created by Matheus Costa on 20/02/19.
//  Copyright © 2019 Matheus Costa. All rights reserved.
//

import UIKit

class ViewController: UIViewController, Storyboarded {
    weak var coordinator: MainCoordinator?
    
    @IBOutlet weak var product: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func buyTapped(_ sender: UIButton) {
        self.coordinator?.buySubscription(to: self.product.selectedSegmentIndex)
    }
    
    @IBAction func createAccountTapped(_ sender: UIButton) {
        self.coordinator?.createAccount()
    }
    
}

