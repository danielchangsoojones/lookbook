//
//  SubscriptionDataStore.swift
//  lookbook
//
//  Created by Dan Kwun on 2/10/22.
//

import UIKit
import Parse

class SubscriptionDataStore {
    func getInfluencerInfo(influencer: InfluencerParse, completion: @escaping (InfluencerParse) -> Void) {
        let query = InfluencerParse.query() as! PFQuery<InfluencerParse>
        query.includeKey("user")
        query.whereKey("objectId", equalTo: influencer.objectId ?? "")
        query.getFirstObjectInBackground { (result, error) in
            if let influencerParse = result {
                completion(influencerParse)
            } else {
                BannerAlert.show(with: error)
            }
        }
    }
        
    func saveSubscription(influencerObjectId: String, subscriptionObjectId: String, chargeAmount: Double, current_period_start: Date, current_period_end: Date, completion: @escaping () -> Void) {
        let parameters: [String: Any] = ["influencerObjectId": influencerObjectId,
                                         "subscriptionObjectId": subscriptionObjectId,
                                         "chargeAmount": chargeAmount,
                                         "current_period_start": current_period_start,
                                         "current_period_end": current_period_end]
        PFCloud.callFunction(inBackground: "saveSubscription", withParameters: parameters) { (result, error) in
            if result != nil {
                completion()
            } else if let error = error {
                BannerAlert.show(with: error)
            } else {
                BannerAlert.showUnknownError(functionName: "saveSubscription")
            }
        }
    }
}
