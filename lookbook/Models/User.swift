//
//  User.swift
//  lookbook
//
//  Created by Dan Kwun on 2/7/22.
//

import UIKit
import Parse

class User: PFUser {
    @NSManaged var isCeleb: Bool
    @NSManaged private var firstName: String?
    @NSManaged var lastName: String?
    @NSManaged var phoneNumber: Double
    @NSManaged var deviceType: String?
    
}
