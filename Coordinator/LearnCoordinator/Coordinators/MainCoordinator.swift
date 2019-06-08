//
//  MainCoordinator.swift
//  LearnCoordinator
//
//  Created by Matheus Costa on 20/02/19.
//  Copyright © 2019 Matheus Costa. All rights reserved.
//

import Foundation
import UIKit

class MainCoordinator: NSObject, Coordinator {
    
    var childCoordinators: [Coordinator]
    var navigationController: UINavigationController
    
    // Should receive a navigation controller because this coordinator might
    // have another as a parent and there is already another navigation controller to be manipulated.
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.childCoordinators = [Coordinator]()
    }
    
    func start() {
        self.navigationController.delegate = self
        
        let vc = ViewController.instantiate()
        vc.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 0)
        vc.coordinator = self
        self.navigationController.pushViewController(vc, animated: false)
    }
    
    func buySubscription(to productType: Int) {
        let child = BuyCoordinator(navigationController: self.navigationController, selectedProduct: productType)
        self.childCoordinators.append(child)
        child.start()
    }
    
    func createAccount() {
        let vc = CreateAccountViewController.instantiate()
        vc.coordinator = self
        self.navigationController.pushViewController(vc, animated: true)
    }
    
    func childDidFinish(_ child: Coordinator?) {
        guard let child = child else { return }
        
        for (index, coordinator) in self.childCoordinators.enumerated() {
            if coordinator === child {
                self.childCoordinators.remove(at: index)
                break
            }
        }
    }
    
}

extension MainCoordinator: UINavigationControllerDelegate {
    
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        guard let fromViewController = navigationController.transitionCoordinator?.viewController(forKey: .from) else { return }
        
        if navigationController.viewControllers.contains(fromViewController) {
            return
        }
        
        if let buyViewController = fromViewController as? BuyViewController {
            self.childDidFinish(buyViewController.coordinator)
        }
    }
    
}
