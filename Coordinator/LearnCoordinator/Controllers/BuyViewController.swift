//
//  BuyViewController.swift
//  LearnCoordinator
//
//  Created by Matheus Costa on 20/02/19.
//  Copyright © 2019 Matheus Costa. All rights reserved.
//

import UIKit

class BuyViewController: UIViewController, Storyboarded {
    
    weak var coordinator: BuyCoordinator?
    
    var selectedProduct = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(selectedProduct)
    }

}
