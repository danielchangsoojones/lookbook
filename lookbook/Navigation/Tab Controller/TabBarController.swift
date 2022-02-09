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
    private var startIndex: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewControllers = createViewControllers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.selectedIndex = startIndex
    }
    
    init(startIndex: Int) {
        self.startIndex = startIndex
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func createViewControllers() -> [UIViewController] {
        let chatIcon = UIImage(named: "chatroom_icon") ?? UIImage()
        let exploreIcon = UIImage(named: "discover_icon") ?? UIImage()
        let settingsIcon =  UIImage(named: "settings_icon") ?? UIImage()
        let masterChatVC = createViewController(type: MasterChatRoomViewController.self, title: "Chat", icon: chatIcon, tab: .chatRooms)
        let discoverVC = createViewController(type: ExploreViewController.self, title: "Discover", icon: exploreIcon, tab: .discover)
        let accountVC = createViewController(type: AccountViewController.self, title: "Account", icon: settingsIcon, tab: .settings)
        let array = [masterChatVC, discoverVC, accountVC]
        
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
