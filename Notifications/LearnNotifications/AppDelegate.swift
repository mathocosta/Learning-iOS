//
//  AppDelegate.swift
//  LearnNotifications
//
//  Created by Matheus Costa on 09/10/18.
//  Copyright © 2018 Matheus Costa. All rights reserved.
//

import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let center = UNUserNotificationCenter.current()
        
        center.requestAuthorization(options: [.sound, .alert]) { (success, error) in
            if let error = error {
                print(error.localizedDescription)
            }
        }
        
        center.delegate = self
        
        return true
    }

}

extension AppDelegate: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        
        switch response.notification.request.content.categoryIdentifier {
        case "GENERAL":
            break
        case "INVITATION":
            switch response.actionIdentifier {
            case "remindLater":
                print("remindLater Action")
            case "accept":
                print("accept Action")
            default:
                break
            }
        default:
            break
        }
        
        completionHandler()
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.sound, .alert])
    }
}

