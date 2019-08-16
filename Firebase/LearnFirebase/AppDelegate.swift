//
//  AppDelegate.swift
//  LearnFirebase
//
//  Created by Matheus Oliveira Costa on 14/08/19.
//  Copyright © 2019 Matheus Oliveira Costa. All rights reserved.
//

import UIKit
import Firebase

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

        FirebaseApp.configure()

        return true
    }

}

