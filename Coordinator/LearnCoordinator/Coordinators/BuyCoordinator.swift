//
//  BuyCoordinator.swift
//  LearnCoordinator
//
//  Created by Matheus Costa on 20/02/19.
//  Copyright © 2019 Matheus Costa. All rights reserved.
//

import UIKit

class BuyCoordinator: Coordinator {

    var childCoordinators: [Coordinator]
    var navigationController: UINavigationController
    var selectedProduct: Int
    
    init(navigationController: UINavigationController, selectedProduct: Int) {
        self.navigationController = navigationController
        self.childCoordinators = [Coordinator]()
        self.selectedProduct = selectedProduct
    }
    
    func start() {
        let vc = BuyViewController.instantiate()
        vc.coordinator = self
        vc.selectedProduct = self.selectedProduct
        self.navigationController.pushViewController(vc, animated: true)
    }

}
