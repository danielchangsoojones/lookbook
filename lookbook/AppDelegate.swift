//
//  AppDelegate.swift
//  lookbook
//
//  Created by Daniel Jones on 1/12/22.
//

import UIKit
import Parse
import Stripe

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        setUpServer()
        setStartingVC()
        
        application.registerForRemoteNotifications()
        return true
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let installation = PFInstallation.current()
        installation?.setDeviceTokenFrom(deviceToken)
        installation?.saveInBackground()
            
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        if error._code == 3010 {
            print("Push notifications are not supported in the iOS Simulator.")
        } else {
            print("application:didFailToRegisterForRemoteNotificationsWithError: %@", error)
        }
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        PFPush.handle(userInfo)
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        User.current()?.fetchInBackground()
    }
    // set orientations you want to be allowed in this property by default
    var orientationLock = UIInterfaceOrientationMask.portrait

    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return self.orientationLock
    }
    
    private func setUpServer() {
        let configuration = ParseClientConfiguration {
            $0.applicationId = Configuration.environment.appID
            $0.server = Configuration.environment.serverURL
        }
        Parse.initialize(with: configuration)
        
        User.registerSubclass()
        //configure Stripe
        STPAPIClient.shared.publishableKey = Configuration.environment.stripePublishableKey
    }
}

extension AppDelegate {
    var isLoggedIn: Bool {
        return User.current() != nil
    }

    private func setStartingVC() {
        if isLoggedIn {
            if (User.current()?.isInfluencer ?? false) {
                Influencer.loadInfluencer {
                    self.toTabBarController()
                }
            } else if OnboardingDataStore.isProfileComplete {
                toTabBarController()
            } else {
                let welcomeVC = CreateProfileViewController()
                let navController = UINavigationController(rootViewController: welcomeVC)
                set(startingVC: navController)
            }
        } else {
            toWelcomeVC()
        }
    }
    
    private func toWelcomeVC() {
        let welcomeVC = WelcomeViewController()
        let navController = UINavigationController(rootViewController: welcomeVC)
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
