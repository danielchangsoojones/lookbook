//
//  ExploreDataStore.swift
//  lookbook
//
//  Created by Dan Kwun on 2/8/22.
//

import UIKit
import Parse

class ExploreDataStore {
    func getAllInfluencers(completion: @escaping ([InfluencerParse]) -> Void) {
        PFCloud.callFunction(inBackground: "getAllInfluencers", withParameters: [:]) { (result, error) in
            if let result = result as? [InfluencerParse] {
                completion(result)
            } else if let error = error {
                BannerAlert.show(with: error)
            } else {
                BannerAlert.showUnknownError(functionName: "getAllInfluencers")
            }
        }
    }
}
