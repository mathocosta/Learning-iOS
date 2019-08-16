//
//  HomeViewController.swift
//  LearnFirebase
//
//  Created by Matheus Oliveira Costa on 14/08/19.
//  Copyright © 2019 Matheus Oliveira Costa. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    var welcomeLabelText: String!

    @IBOutlet weak var welcomeLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.welcomeLabel.text = self.welcomeLabelText
    }

}

