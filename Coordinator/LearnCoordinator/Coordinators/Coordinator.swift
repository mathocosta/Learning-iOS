//
//  Coordinator.swift
//  LearnCoordinator
//
//  Created by Matheus Costa on 20/02/19.
//  Copyright © 2019 Matheus Costa. All rights reserved.
//

import Foundation
import UIKit

// Base protocol to all coordinators of the app.
protocol Coordinator: AnyObject {
    // This property allows a tree of coordinators to exist and they relate to each other.
    var childCoordinators: [Coordinator] { get set }
    
    // The base navigation controller.
    var navigationController: UINavigationController { get set }
    
    func start()
}
