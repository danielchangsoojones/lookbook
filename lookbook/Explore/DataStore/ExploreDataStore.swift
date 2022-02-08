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
    
    func createChatRoom(influencerObjectId: String, completion: @escaping (Bool) -> Void) {
        let parameters: [String: Any] = ["influencerObjectId": influencerObjectId]
        PFCloud.callFunction(inBackground: "createChatRoomWithInfluencer", withParameters: parameters) { (result, error) in
            if result != nil {
                completion(true)
            } else if let error = error {
                BannerAlert.show(with: error)
            } else {
                BannerAlert.showUnknownError(functionName: "createChatRoomWithInfluencer")
            }
        }
    }
}
