//
//  NotificationViewController.swift
//  NotificationContentExtension
//
//  Created by Matheus Costa on 09/10/18.
//  Copyright © 2018 Matheus Costa. All rights reserved.
//

import UIKit
import UserNotifications
import UserNotificationsUI

class NotificationViewController: UIViewController, UNNotificationContentExtension {
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func didReceive(_ notification: UNNotification) {
        self.imageView.image = #imageLiteral(resourceName: "cat")
        self.title = "3d é chato"
    }

}
