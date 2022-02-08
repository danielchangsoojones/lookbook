//
//  HomeViewController.swift
//  lookbook
//
//  Created by Dan Kwun on 2/7/22.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let homeView = HomeView(frame: self.view.bounds)
        self.view = homeView
    }

}
