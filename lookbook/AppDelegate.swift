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
        setStartingVC()
//        showInitialVC()
        return true
    }
    //    private func showInitialVC() {
    //        let welcomeVC = ExploreViewController()
    //        let navController = UINavigationController(rootViewController: welcomeVC)
    //        navController.modalPresentationStyle = .fullScreen
    //        set(startingVC: navController)
    //    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        User.current()?.fetchInBackground()
    }
    
    private func setUpServer() {
        let configuration = ParseClientConfiguration {
            $0.applicationId = Configuration.environment.appID
            $0.server = Configuration.environment.serverURL
        }
        Parse.initialize(with: configuration)
        
        User.registerSubclass()
    }
}

extension AppDelegate {
    var isLoggedIn: Bool {
        return User.current() != nil
    }
    
    private func setStartingVC() {
        if isLoggedIn {
            toTabBarController()
        } else {
            toWelcomeVC()
        }
    }
    
    private func toWelcomeVC() {
        let welcomeVC = WelcomeViewController()
        let navController = UINavigationController(rootViewController: welcomeVC)
        navController.modalPresentationStyle = .fullScreen
        set(startingVC: navController)
    }
    
    private func toTabBarController() {
        let tabController = TabBarController()
        set(startingVC: tabController)
    }
    
    private func set(startingVC: UIViewController) {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = startingVC
        self.window?.makeKeyAndVisible()
    }
}
