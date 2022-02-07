//
//  AppDelegate.swift
//  lookbook
//
//  Created by Daniel Jones on 1/12/22.
//

import UIKit
import Parse

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        setUpServer()
        showInitialVC()
        return true
    }
    
    private func setUpServer() {
        let configuration = ParseClientConfiguration {
            $0.applicationId = "ohanafam27485939273899921861"
            $0.server = "https://ohanafam-server-prod.herokuapp.com/parse"
        }
        Parse.initialize(with: configuration)
        
        User.registerSubclass()
    }
    
    private func showInitialVC() {
        let welcomeVC = WelcomeViewController()
        let navController = UINavigationController(rootViewController: welcomeVC)
        navController.modalPresentationStyle = .fullScreen
        set(startingVC: navController)
    }
    
    private func set(startingVC: UIViewController) {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = startingVC
        self.window?.makeKeyAndVisible()
    }
}

