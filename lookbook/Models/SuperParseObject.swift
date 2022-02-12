//
//  SuperParseObject.swift
//  lookbook
//
//  Created by Dan Kwun on 2/7/22.
//

import Foundation
import Parse

class SuperParseObject: PFObject {
    struct Constants {
        static let objectId = "objectId"
        static let updatedAt = "updatedAt"
        static let createdAt = "createdAt"
    }
    
    override static func query() -> PFQuery<PFObject>? {
        let query = super.query()
        return query
    }
}
