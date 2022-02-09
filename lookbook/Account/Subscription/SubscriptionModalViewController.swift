//
//  SubscriptionModalViewController.swift
//  lookbook
//
//  Created by Dan Kwun on 2/8/22.
//

import UIKit

class SubscriptionModalViewController: UIViewController {
    private var influencer: InfluencerParse!
    private var mainLabel: UILabel!
    private var infoTitleLabel: UILabel!
    private var infoSubtitleLabel: UILabel!
    
    init(influencer: InfluencerParse) {
        self.influencer = influencer
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let subscriptionView = SubscriptionModalView(frame: self.view.bounds)
        self.view = subscriptionView
        mainLabel = subscriptionView.mainLabel
        infoTitleLabel = subscriptionView.infoTitleLabel
        infoSubtitleLabel = subscriptionView.infoSubtitleLabel
        subscriptionView.exitButton.addTarget(self, action: #selector(exitButtonPressed), for: .touchUpInside)
        subscriptionView.subscribeButton.addTarget(self, action: #selector(subscribeButtonPressed), for: .touchUpInside)
        updateLabels()
    }
    
    private func updateLabels() {
        let influencerName = influencer.user.name ?? ""
        let subscriptionPrice = Int(influencer.subscriptionPrice)
        mainLabel.text = "\(influencerName)'s Membership"
        infoTitleLabel.text = "$\(subscriptionPrice) per month"
        infoSubtitleLabel.text = "• Private DMs with the one and only \(influencerName)!\n• Get photos and videos that \(influencerName) would send to their friends. Why? Because you’re now \(influencerName)'s friend! : ) "
    }
    
    @objc private func exitButtonPressed() {
        dismiss(animated: true, completion: nil)
    }

    @objc private func subscribeButtonPressed() {
        //TODO: go to Stripe's check out page
        dismiss(animated: true, completion: nil)
    }
}
