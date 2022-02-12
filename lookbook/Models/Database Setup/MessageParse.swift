//
//  MessageParse.swift
//  lookbook
//
//  Created by Dan Kwun on 2/8/22.
//

import UIKit
import Parse

class MessageParse: SuperParseObject, PFSubclassing {
    @NSManaged var message: String
    @NSManaged var isSenderInfluencer: Bool
    @NSManaged var fan: User
    @NSManaged var celeb: InfluencerParse
    @NSManaged var hasRead: Date?
    @NSManaged var type: String
    
    class func parseClassName() -> String {
        return "Message"
    }
}
