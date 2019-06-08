//
//  MainTabBarController.swift
//  LearnCoordinator
//
//  Created by Matheus Costa on 20/02/19.
//  Copyright © 2019 Matheus Costa. All rights reserved.
//

import UIKit

// Here is shown how it is entirely possible to use the standard coordinator with a TabBar,
// in which case each tab must have a coordinator to control the flow of that tab.
class MainTabBarController: UITabBarController {
    let main = MainCoordinator(navigationController: UINavigationController())
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.main.start()
        viewControllers = [main.navigationController]
    }

}
