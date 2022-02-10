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
        PFCloud.callFunction(inBackground: "setupStripeCustomer", withParameters: [:]) { (result, error) in
            if result != nil {
                print("successfully ran setupStripeCustomer")
            } else if let error = error {
                BannerAlert.show(with: error)
            } else {
                BannerAlert.showUnknownError(functionName: "setupStripeCustomer")
            }
        }
    }
}
