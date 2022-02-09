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
    
    func logIn(email: String, password: String) {
        let lowerCaseEmail = email.lowercased().removeWhitespaces()
        User.logInWithUsername(inBackground: lowerCaseEmail, password: password) { (user, error) -> Void in
            if let _ = user, error == nil {
                let installation = PFInstallation.current()
                installation!["user"] = User.current()
                installation!.saveEventually(nil)
                self.delegate?.segueIntoApp()
            } else if let error = error, let code = PFErrorCode(rawValue: error._code) {
                if code == .errorObjectNotFound {
                    self.delegate?.showError(title: "Login Failed", subtitle: error.localizedDescription)
                }
            }
        }
    }
    
    func resetPassword(email: String, completion: @escaping(Bool) -> Void) {
        PFUser.requestPasswordResetForEmail(inBackground: email) { (success: Bool, error: Error?) in
            if success {
                BannerAlert.show(title: "Email Found",
                                  subtitle: "It may take a couple minutes for the reset link email to show up. You may want to check your spam folder as well!",
                                  type: .success)
                completion(success)
            } else if let error = error, let code = PFErrorCode(rawValue: error._code) {
                var type = ""
                switch code {
                case .errorUserWithEmailNotFound:
                    type = "Email Not Found"
                default:
                    type = "Reset Password Error"
                }
                BannerAlert.show(title: type,
                                  subtitle: error.localizedDescription,
                                  type: .error)
                
            } else {
                BannerAlert.showUnknownError(functionName: "Password Reset")
            }
        }
    }
    
    func save(name: String, phoneNumber: Double) {
        if let currentUser = User.current() {
            currentUser.name = name
            currentUser.phoneNumber = phoneNumber
            currentUser.saveInBackground()
        }
    }
}
