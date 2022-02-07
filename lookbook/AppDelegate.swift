//
//  AppDelegate.swift
//  lookbook
//
//  Created by Daniel Jones on 1/12/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        showInitialVC()
        return true
    }
    
    private func showInitialVC() {
        let welcomeVC = WelcomeViewController()
        set(startingVC: welcomeVC)
    }
    
    private func set(startingVC: UIViewController) {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = startingVC
        self.window?.makeKeyAndVisible()
    }
}

