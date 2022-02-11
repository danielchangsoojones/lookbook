//
//  MessengerDataStore.swift
//  lookbook
//
//  Created by Dan Kwun on 2/11/22.
//

import UIKit
import Parse

class MessengerDataStore: NSObject {
    //TODO: DJ will be working on backend.
    func loadMessages(influencerObjectId: String, completion: @escaping ([MessageParse]) -> Void) {
        let parameters: [String: Any] = ["influencerObjectId": influencerObjectId]
        PFCloud.callFunction(inBackground: "loadMessages", withParameters: parameters) { (result, error) in
            if let result = result as? [MessageParse] {
                completion(result)
            } else if let error = error {
                BannerAlert.show(with: error)
            } else {
                BannerAlert.showUnknownError(functionName: "loadMessages")
            }
        }
    }
}
