//
//  StripeManager.swift
//  lookbook
//
//  Created by Dan Kwun on 2/9/22.
//

import UIKit
import Stripe
import Parse
 
class StripeManager: NSObject {
    var defaultPaymentMethod: STPPaymentMethod?
    static let shared = StripeManager()
    
    func setupStripeCustomer() {
        PFCloud.callFunction(inBackground: "setupStripeCustomer", withParameters: [:]) { (stripeCustomerID, error) in
            if let stripeCustomerID = stripeCustomerID as? String {
                User.current()?.stripeCustomerID = stripeCustomerID
            } else if let error = error {
                BannerAlert.show(with: error)
            } else {
                BannerAlert.showUnknownError(functionName: "setupStripeCustomer")
            }
        }
    }
}

class StripeEphemeralKeyProvider: NSObject, STPCustomerEphemeralKeyProvider {
    static let sharedClient = StripeEphemeralKeyProvider()
    
    func createCustomerKey(withAPIVersion apiVersion: String, completion: @escaping STPJSONResponseCompletionBlock) {
        if let stripeCustomerID = User.current()?.stripeCustomerID {
            self.loadStripeEphemeralKey(withAPIVersion: apiVersion,
                                        stripeCustomerID: stripeCustomerID,
                                        completion: completion)
        } else {
            let error = CustomError(msg: "Stripe Customer does not exist yet")
            completion(nil, error)
        }
    }
    
    private func loadStripeEphemeralKey(withAPIVersion apiVersion: String, stripeCustomerID: String, completion: @escaping STPJSONResponseCompletionBlock) {
        let parameters: [String: Any] = ["api_version": apiVersion, "customerID": stripeCustomerID]
        PFCloud.callFunction(inBackground: "getStripeEphemeralKey", withParameters: parameters) { (key, error) in
            if let key = key as? [String: AnyObject] {
                completion(key, nil)
            } else if let error = error {
                completion(nil, error)
            } else {
                completion(nil, nil)
            }
        }
    }
}
