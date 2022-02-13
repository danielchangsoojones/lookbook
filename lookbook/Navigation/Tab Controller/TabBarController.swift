//
//  TabBarController.swift
//  lookbook
//
//  Created by Dan Kwun on 2/8/22.
//

import UIKit

enum Tab: Int {
    case chatRooms
    case discover
    case settings
}

class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let isUserInfluencer = User.current()?.influencer != nil ? true : false
        self.viewControllers = createViewControllers(isUserInfluencer: isUserInfluencer)
        loadStartScreen(isUserInfluencer: isUserInfluencer)
        StripeManager.shared.setupStripeCustomer()
    }
    
    private func loadStartScreen(isUserInfluencer: Bool) {
        let masterChatDataStore = MasterChatDataStore()
        masterChatDataStore.getMasterChatRooms(isUserInfluencer: isUserInfluencer) { chatRooms in
            if isUserInfluencer {
                self.selectedIndex = 0
            } else {
                if chatRooms.count > 1 {
                    //open MasterChatVC
                    self.selectedIndex = 0
                } else if chatRooms.count == 1 {
                    //open ChatVC
                    self.selectedIndex = 0
                    if let currentUser = User.current() {
                        let navController = self.viewControllers?[0] as! UINavigationController
                        navController.viewControllers[0].pushVC(ChatViewController(influencer: chatRooms[0].influencer, fan: currentUser, isUserInfluencer: false))
                    }
                } else {
                    //open ExploreVC
                    self.selectedIndex = 1
                }
            }
        }
    }


    private func createViewControllers(isUserInfluencer: Bool) -> [UIViewController] {
        let chatIcon = UIImage(named: "chatroom_icon") ?? UIImage()
        let exploreIcon = UIImage(named: "discover_icon") ?? UIImage()
        let settingsIcon =  UIImage(named: "settings_icon") ?? UIImage()
        let masterChatVC = createViewController(type: MasterChatRoomViewController.self, title: "Chat", icon: chatIcon, tab: .chatRooms)
        let discoverVC = createViewController(type: ExploreViewController.self, title: "Discover", icon: exploreIcon, tab: .discover)
        let accountVC = createViewController(type: AccountViewController.self, title: "Account", icon: settingsIcon, tab: .settings)
        var array = [masterChatVC, discoverVC, accountVC]
        if isUserInfluencer {
            array = [masterChatVC, accountVC]
        }
        
        return array
    }
    
    private func createViewController(type vcType: UIViewController.Type, title: String, icon: UIImage, tab: Tab) -> UIViewController {
        let vc = vcType.init()
        vc.tabBarItem = createTabBarItem(title: title, image: icon, tag: tab.rawValue)
        tabBar.backgroundColor = .white
        let navController = UINavigationController(rootViewController: vc)
        return navController
    }
    
    private func createTabBarItem(title: String, image: UIImage, tag: Int) -> UITabBarItem {
        let item = UITabBarItem(title: title, image: image, tag: tag)
        return item
    }
}
