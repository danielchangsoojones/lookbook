//
//  OnboardingDataStore.swift
//  lookbook
//
//  Created by Dan Kwun on 2/7/22.
//

import UIKit
import Parse

class OnboardingDataStore: NSObject {
    func register(email: String, password: String) {
        let newUser = User()
        newUser.username = email.lowercased()
        newUser.password = password
        newUser.email = email.lowercased()
        newUser.deviceType = "iOS"
        
        newUser.signUpInBackground { (success, error: Error?) -> Void in
            if success {
                let installation = PFInstallation.current()
                installation!["user"] = User.current()
                installation!.saveInBackground()
            }
            else {
                //TODO: error calls
            }
        }
    }
}
