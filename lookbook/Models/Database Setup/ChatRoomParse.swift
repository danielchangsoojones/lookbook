//
//  ChatRoomParse.swift
//  lookbook
//
//  Created by Dan Kwun on 2/8/22.
//


import Foundation
import Parse

class ChatRoomParse: SuperParseObject, PFSubclassing {
    @NSManaged var fan: User
    @NSManaged var influencer: InfluencerParse
    @NSManaged var latestMessage: MessageParse?
    
    class func parseClassName() -> String {
        return "ChatRoom"
    }
}
