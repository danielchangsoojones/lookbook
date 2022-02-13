//
//  MessengerDataStore.swift
//  lookbook
//
//  Created by Dan Kwun on 2/11/22.
//

import UIKit
import Parse

class MessengerDataStore: NSObject {
    func sendBroadcast(messageText: String, completion: @escaping () -> Void) {
        let parameters: [String: Any] = ["messageText": messageText]
        PFCloud.callFunction(inBackground: "sendBroadcast", withParameters: parameters) { (result, error) in
            if result != nil {
                completion()
            } else if let error = error {
                BannerAlert.show(with: error)
            } else {
                BannerAlert.showUnknownError(functionName: "sendMessage")
            }
        }
    }
    
    func sendMessage(fanId: String, influencerID: String, isUserInfluencer: Bool, messageText: String, messageType: String, completion: @escaping (ChatRoomParse) -> Void) {
        let parameters: [String: Any] = ["fanId": fanId,
                                         "influencerID": influencerID,
                                         "isUserInfluencer": isUserInfluencer,
                                         "messageText": messageText,
                                         "messageType": messageType]
        PFCloud.callFunction(inBackground: "sendMessage", withParameters: parameters) { (result, error) in
            if let result = result as? ChatRoomParse {
                completion(result)
            } else if let error = error {
                BannerAlert.show(with: error)
            } else {
                BannerAlert.showUnknownError(functionName: "sendMessage")
            }
        }
    }
    
    func loadMessages(fanId: String, influencerID: String, isUserInfluencer: Bool, lastMsgTimeStamp: Date? = nil, completion: @escaping ([ChatMessage], Bool) -> Void) {
        var parameters: [String: Any] = ["fanId": fanId, "influencerID": influencerID, "isUserInfluencer": isUserInfluencer]
        if let lastMsgTimeStamp = lastMsgTimeStamp {
            parameters = ["fanId": fanId, "influencerID": influencerID, "isUserInfluencer": isUserInfluencer, "lastMsgTimeStamp": lastMsgTimeStamp]
        }
        PFCloud.callFunction(inBackground: "loadMessages", withParameters: parameters) { (result, error) in
            if let result = result as? [String : Any] {
                if let messageParses = result["messages"] as? [MessageParse],
                   let hasUserReachedLimit = result["hasUserReachedLimit"] as? Bool {
                    let finalMessages = messageParses.map { (messageParse) -> ChatMessage in
                        return ChatMessage(messageParse: messageParse, isSenderInfluencer: messageParse.isSenderInfluencer, localMsg: nil)
                    }
                    completion(finalMessages, hasUserReachedLimit)
                }
            } else if let error = error {
                BannerAlert.show(with: error)
            } else {
                BannerAlert.showUnknownError(functionName: "loadMessages")
            }
        }
    }
}
