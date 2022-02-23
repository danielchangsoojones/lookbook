//
//  Influencer.swift
//  lookbook
//
//  Created by Daniel Jones on 2/22/22.
//

import Foundation
import Parse

class Influencer {
    static var shared: Influencer?
    let influencerParse: InfluencerParse
    
    init(influencerParse: InfluencerParse) {
        self.influencerParse = influencerParse
    }
    
    static func loadInfluencer(completion: @escaping () -> ()) {
        if let currentUser = User.current() {
            let query = InfluencerParse.query() as! PFQuery<InfluencerParse>
            query.whereKey("user", equalTo: currentUser)
            query.getFirstObjectInBackground { influencerParse, error in
                if let influencerParse = influencerParse {
                    let influencer = Influencer(influencerParse: influencerParse)
                    self.shared = influencer
                    completion()
                } else if let error = error {
                    BannerAlert.show(with: error)
                } else {
                    BannerAlert.show(title: "Error", subtitle: "Error loading influencer", type: .error)
                }
            }
        }
    }
}
