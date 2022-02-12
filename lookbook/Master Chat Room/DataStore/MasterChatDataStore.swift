//
//  MasterChatDataStore.swift
//  lookbook
//
//  Created by Dan Kwun on 2/8/22.
//

import UIKit
import Parse

class MasterChatDataStore {
    func getMasterChatRooms(isUserInfluencer: Bool, completion: @escaping ([ChatRoomParse]) -> Void) {
        let parameters: [String: Any] = ["isUserInfluencer": isUserInfluencer]
        PFCloud.callFunction(inBackground: "getMasterChatRooms", withParameters: [:]) { (result, error) in
            if let result = result as? [ChatRoomParse] {
                completion(result)
            } else if let error = error {
                BannerAlert.show(with: error)
            } else {
                BannerAlert.showUnknownError(functionName: "getMasterChatRooms")
            }
        }
    }
}
