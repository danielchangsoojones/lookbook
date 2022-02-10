//
//  SubscriptionModalViewController.swift
//  lookbook
//
//  Created by Dan Kwun on 2/8/22.
//

import UIKit
import Stripe
import Foundation

class SubscriptionModalViewController: UIViewController {
    private var influencer: InfluencerParse!
    private var mainLabel: UILabel!
    private var infoTitleLabel: UILabel!
    private var infoSubtitleLabel: UILabel!
    private var paymentSheet: PaymentSheet?
    
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
        setupPaymentContext()
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
    
    private func setupPaymentContext() {
        StripeEphemeralKeyProvider.sharedClient.createCustomerKey(withAPIVersion: influencer.objectId ?? "") { result, error in
            if let result = result {
                if let ephemeralKey = result["ephemeralKey"] as? [AnyHashable: Any],
                   let paymentIntent = result["paymentIntent"] as? [AnyHashable: Any] {
                    if let customerEphemeralKeySecret = ephemeralKey["secret"] as? String,
                       let paymentIntentClientSecret = paymentIntent["client_secret"] as? String,
                       let customerStripeID = User.current()?.stripeCustomerID {
                        var configuration = PaymentSheet.Configuration()
                        configuration.merchantDisplayName = "Ohana"
                        configuration.customer = .init(id: customerStripeID, ephemeralKeySecret: customerEphemeralKeySecret)
                        self.paymentSheet = PaymentSheet(paymentIntentClientSecret: paymentIntentClientSecret, configuration: configuration)
                    } else {
                        BannerAlert.show(title: "Secret Key Needed", subtitle: "Secret Keys does not exist", type: .error)
                    }
                } else {
                    BannerAlert.show(title: "Key/Intent Needed", subtitle: "EphemeralKey or Payment Intent does not exist", type: .error)
                }
            } else if let error = error {
                BannerAlert.show(with: error)
            } else {
                BannerAlert.showUnknownError(functionName: "setupPaymentContext")
            }
        }
    }
    
    @objc private func subscribeButtonPressed() {
        paymentSheet?.present(from: self) { paymentResult in
            switch paymentResult {
            case .completed:
                print("Your order is confirmed")
                BannerAlert.show(title: "Payment Success", subtitle: "You've successfully subscribed!", type: .success)
                //TODO: record entry on Subscription table
            case .canceled:
                print("Canceled!")
            case .failed(let error):
                BannerAlert.show(with: error)
            }
        }
    }
}
