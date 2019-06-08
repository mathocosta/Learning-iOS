//
//  ViewController.swift
//  LearnNotifications
//
//  Created by Matheus Costa on 09/10/18.
//  Copyright © 2018 Matheus Costa. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Creating a local notification.
        let content = UNMutableNotificationContent()
        content.title = "Invitation"
        content.subtitle = "This is a Local Notification."
        content.body = "You are invited."
        content.categoryIdentifier = "INVITATION"
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 2, repeats: false)
        
        let request = UNNotificationRequest(identifier: "Anniversary", content: content, trigger: trigger)
        
        // Configuring actions.
        let remindLaterAction = UNNotificationAction(identifier: "remindLater", title: "Remind me later", options: .foreground)
        let acceptAction = UNNotificationAction(identifier: "accept", title: "Accept", options: .foreground)
        let declineAction = UNNotificationAction(identifier: "decline", title: "Decline", options: .destructive)
        let commentAction = UNTextInputNotificationAction(identifier: "comment", title: "Comment", options: .authenticationRequired,
                                                          textInputButtonTitle: "Send", textInputPlaceholder: "Share your thoughts..")
        
        // Configure notification category.
        let invitationCategory = UNNotificationCategory(identifier: "INVITATION",
                                                        actions: [remindLaterAction, acceptAction, declineAction, commentAction],
                                                        intentIdentifiers: [], options: UNNotificationCategoryOptions(rawValue: 0))
        
        let center = UNUserNotificationCenter.current()
        
        //Register the app’s notification types and the custom actions that they support.
        center.setNotificationCategories([invitationCategory])
        
        center.add(request) { (error) in
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }


}

