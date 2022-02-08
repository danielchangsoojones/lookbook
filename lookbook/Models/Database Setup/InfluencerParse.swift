//
//  InfluencerParse.swift
//  lookbook
//
//  Created by Dan Kwun on 2/7/22.
//

import Foundation
import Parse

class InfluencerParse: SuperParseObject, PFSubclassing {
    @NSManaged var user: User
    @NSManaged var welcomeMessage: String
    @NSManaged var welcomePhoto: PFFileObject?
    @NSManaged var chatBackgroundPhoto: PFFileObject?
    
    class func parseClassName() -> String {
        return "Influencer"
    }
}
