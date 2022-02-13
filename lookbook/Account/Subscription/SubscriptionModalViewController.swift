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
    private var titleLabel: UILabel!
    private var infoTitleLabel: UILabel!
    private var infoSubtitleLabel: UILabel!
    private var paymentSheet: PaymentSheet?
    private var dataStore = SubscriptionDataStore()
    private var subscriptionId: String!
    private var chargeAmount: Double!
    private var current_period_start: Date!
    private var current_period_end: Date!
    
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
        titleLabel = subscriptionView.titleLabel
        infoTitleLabel = subscriptionView.infoTitleLabel
        infoSubtitleLabel = subscriptionView.infoSubtitleLabel
        subscriptionView.exitButton.addTarget(self, action: #selector(exitButtonPressed), for: .touchUpInside)
        subscriptionView.subscribeButton.addTarget(self, action: #selector(subscribeButtonPressed), for: .touchUpInside)
        getInfluencerInfo()
        setupPaymentContext()
    }
    
    private func getInfluencerInfo() {
        dataStore.getInfluencerInfo(influencer: influencer) { influencerParse in
            self.updateLabels(influencerParse: influencerParse)
        }
    }
    
    private func updateLabels(influencerParse: InfluencerParse) {
        let influencerName = influencerParse.user.name ?? ""
        let subscriptionPrice = Int(influencerParse.subscriptionPrice)
        mainLabel.text = "\(influencerName)'s Membership"
        titleLabel.text = "You've reached a limit on messages you can send and receive! Subscribe to directly message with \(influencerName)"
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
                   let paymentIntent = result["paymentIntent"] as? [AnyHashable: Any],
                   let subscription = result["subscription"] as? [AnyHashable: Any] {
                    if let customerEphemeralKeySecret = ephemeralKey["secret"] as? String,
                       let paymentIntentClientSecret = paymentIntent["client_secret"] as? String,
                       let chargeAmount = paymentIntent["amount"] as? Double,
                       let subscriptionId = subscription["id"] as? String,
                       let current_period_start = subscription["current_period_start"] as? Double,
                       let current_period_end = subscription["current_period_end"] as? Double,
                       let customerStripeID = User.current()?.stripeCustomerID {
                        self.subscriptionId = subscriptionId
                        self.chargeAmount = chargeAmount
                        let startEpocTime = TimeInterval(current_period_start)
                        let endEpocTime = TimeInterval(current_period_end)
                        self.current_period_start = Date(timeIntervalSince1970: startEpocTime)
                        self.current_period_end = Date(timeIntervalSince1970: endEpocTime)
                        
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
                BannerAlert.show(title: "Payment Success", subtitle: "You'll be able to receive and send messages moving forward. Try sending a message now!", type: .success)
                self.dismiss(animated: true, completion: nil)
                self.dataStore.saveSubscription(influencerObjectId: self.influencer?.objectId ?? "", subscriptionObjectId: self.subscriptionId, chargeAmount: self.chargeAmount, current_period_start: self.current_period_start, current_period_end: self.current_period_end) {
                    print("successfully saved subscription")
                }
            case .canceled:
                print("Canceled!")
            case .failed(let error):
                BannerAlert.show(with: error)
            }
        }
    }
}
