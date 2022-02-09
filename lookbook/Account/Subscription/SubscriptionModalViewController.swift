//
//  SubscriptionModalViewController.swift
//  lookbook
//
//  Created by Dan Kwun on 2/8/22.
//

import UIKit

class SubscriptionModalViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        let subscriptionView = SubscriptionModalView(frame: self.view.bounds)
        self.view = subscriptionView
        subscriptionView.exitButton.addTarget(self, action: #selector(exitButtonPressed), for: .touchUpInside)
        subscriptionView.subscribeButton.addTarget(self, action: #selector(subscribeButtonPressed), for: .touchUpInside)
    }
     
    //TODO: feed in influencer's name + update on screen with init
    //TODO: set the view content with influencer's things
    
    @objc private func exitButtonPressed() {
        dismiss(animated: true, completion: nil)
    }

    @objc private func subscribeButtonPressed() {
        dismiss(animated: true, completion: nil)
    }
}
