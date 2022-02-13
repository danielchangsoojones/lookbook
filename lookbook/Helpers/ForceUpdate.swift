//
//  ForceUpdate.swift
//  lookbook
//
//  Created by Daniel Jones on 2/12/22.
//

import Foundation
import Parse
import SCLAlertView

class ForceUpdate {
    static func checkIfForceUpdate() {
        let version_str = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String
        if let version_str = version_str {
            let parameters: [String : Any] = ["app_version" : version_str]
            PFCloud.callFunction(inBackground: "checkForceUpdate", withParameters: parameters) { (result, error) in
                if let mustUpdate = result as? Bool {
                    if mustUpdate {
                        showAlert()
                    }
                } else if let error = error {
                    print(error)
                } else {
                    print("unknown error with the checkForceUpdate call")
                }
            }
        }
    }
    
    private static func showAlert() {
        let appearance = SCLAlertView.SCLAppearance(
            showCloseButton: false
        )
        let alertView = SCLAlertView(appearance: appearance)
        alertView.addButton("Update", action: {
            Helpers.open(urlString: "https://apps.apple.com/us/app/id1609559752")
        })
        alertView.showSuccess("Update App", subTitle: "There is a new Ohana version available. Please update your app!")
    }
}
