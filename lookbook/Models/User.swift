//
//  User.swift
//  lookbook
//
//  Created by Dan Kwun on 2/7/22.
//

import Parse

class User: PFUser {
    @NSManaged var influencer: InfluencerParse?
    @NSManaged var profilePhoto: PFFileObject?
    @NSManaged var name: String?
    @NSManaged var phoneNumber: Double
    @NSManaged var deviceType: String?
    @NSManaged var stripeCustomerID: String
}
