//
//  MessengerDataStore.swift
//  lookbook
//
//  Created by Dan Kwun on 2/11/22.
//

import UIKit
import Parse

class MessengerDataStore: NSObject {
    func sendMessage(fanId: String, influencerID: String, isUserInfluencer: Bool, messageText: String, messageType: String, completion: @escaping (MessageParse) -> Void) {
        let parameters: [String: Any] = ["fanId": fanId,
                                         "influencerID": influencerID,
                                         "isUserInfluencer": isUserInfluencer,
                                         "messageText": messageText,
                                         "messageType": messageType]
        PFCloud.callFunction(inBackground: "sendMessage", withParameters: parameters) { (result, error) in
            if let result = result as? MessageParse {
                completion(result)
            } else if let error = error {
                BannerAlert.show(with: error)
            } else {
                BannerAlert.showUnknownError(functionName: "loadMessages")
            }
        }
    }
    
    func loadMessages(fanId: String, influencerID: String, isUserInfluencer: Bool, lastMsgTimeStamp: Date? = nil, completion: @escaping ([ChatMessage]) -> Void) {
        var parameters: [String: Any] = ["fanId": fanId, "influencerID": influencerID, "isUserInfluencer": isUserInfluencer]
        if let lastMsgTimeStamp = lastMsgTimeStamp {
            parameters = ["fanId": fanId, "influencerID": influencerID, "isUserInfluencer": isUserInfluencer, "lastMsgTimeStamp": lastMsgTimeStamp]
        }
        PFCloud.callFunction(inBackground: "loadMessages", withParameters: parameters) { (messageParses, error) in
            if let messageParses = messageParses as? [MessageParse] {
                let finalMessages = messageParses.map { (messageParse) -> ChatMessage in
                    return ChatMessage(messageParse: messageParse, isSenderInfluencer: messageParse.isSenderInfluencer, localMsg: nil)
                }
                completion(finalMessages)
            } else if let error = error {
                BannerAlert.show(with: error)
            } else {
                BannerAlert.showUnknownError(functionName: "loadMessages")
            }
        }
    }
}
