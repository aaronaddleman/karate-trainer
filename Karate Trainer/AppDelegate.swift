//
//  AppDelegate.swift
//  Karate Trainer
//
//  Created by Aaron Addleman on 9/6/24.
//

import UIKit
import WatchConnectivity

class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var sessionManager: iPhoneSessionManager?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Initialize and activate WCSession
        sessionManager = iPhoneSessionManager()
        return true
    }
}
