//
//  Storyboarded.swift
//  LearnCoordinator
//
//  Created by Matheus Costa on 20/02/19.
//  Copyright © 2019 Matheus Costa. All rights reserved.
//

import Foundation
import UIKit

protocol Storyboarded {
    static func instantiate() -> Self
}

extension Storyboarded where Self: UIViewController {
    
    // Get view with identifier equal to ViewController name on main storyboard.
    static func instantiate() -> Self {
        let id = String(describing: self)
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        return storyboard.instantiateViewController(withIdentifier: id) as! Self
    }
    
}
