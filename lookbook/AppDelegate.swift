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
//        showInitialVC()
        loadStartScreen()
        return true
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
    }
    
    private func showInitialVC() {
        let welcomeVC = ExploreViewController()
        let navController = UINavigationController(rootViewController: welcomeVC)
        navController.modalPresentationStyle = .fullScreen
        set(startingVC: navController)
//
//        let chatVC = ChatViewController()
//        let navController = UINavigationController(rootViewController: chatVC)
//        set(startingVC: navController)
    }
    
    private func loadStartScreen() {
        //ExploreVC set as default start screen
        var startIndex = 1
        let masterChatDataStore = MasterChatDataStore()
        masterChatDataStore.getMasterChatRooms { chatRooms in
            if chatRooms.count >= 1 {
                //open MasterChatVC
                startIndex = 0
            }
            self.toTabBarController(startIndex: startIndex)
        }
    }
    
    private func toTabBarController(startIndex: Int) {
        let tabController = TabBarController(startIndex: startIndex)
        set(startingVC: tabController)
    }
    
    private func set(startingVC: UIViewController) {
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = startingVC
        self.window?.makeKeyAndVisible()
    }
}
