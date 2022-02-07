//
//  OnboardingDataStore.swift
//  lookbook
//
//  Created by Dan Kwun on 2/7/22.
//

import UIKit
import Parse

protocol OnboardingDataStoreDelegate: NSObjectProtocol {
    func segueIntoApp()
    func showError(title: String, subtitle: String)
}

class OnboardingDataStore: NSObject {
    weak var delegate: OnboardingDataStoreDelegate?
    
    init(delegate: OnboardingDataStoreDelegate) {
        self.delegate = delegate
    }
    
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
                self.delegate?.segueIntoApp()
            }
            else {
                if let error = error, let code = PFErrorCode(rawValue: error._code) {
                    switch code {
                    case .errorInvalidEmailAddress:
                        self.delegate?.showError(title: "Invalid Email Address", subtitle: "Please enter a valid email address")
                    case .errorUserEmailTaken:
                        self.delegate?.showError(title: "Email Already Taken", subtitle: "Email already exists, please use a different one or log in.")
                    default:
                        self.delegate?.showError(title: "Sign Up Error", subtitle: error.localizedDescription)
                    }
                }
            }
        }
    }
}
