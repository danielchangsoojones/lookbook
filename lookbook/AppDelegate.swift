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
//        setStartingVC()
        setInitialVC()
        return true
    }
    
    private func setInitialVC() {
        let query = InfluencerParse.query() as! PFQuery<InfluencerParse>
        query.includeKey("user")
        query.whereKey("objectId", equalTo: "BnLxDDT7rU")
        query.getFirstObjectInBackground { (result, error) in
            if let influencerParse = result {
                let welcomeVC = SubscriptionModalViewController(influencer: influencerParse)
                let navController = UINavigationController(rootViewController: welcomeVC)
                self.set(startingVC: navController)
            } else {
                BannerAlert.show(with: error)
            }
        }
    }
    
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
            if OnboardingDataStore.isProfileComplete {
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
