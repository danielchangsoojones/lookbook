//
//  Structs.swift
//  lookbook
//
//  Created by Dan Kwun on 2/7/22.
//

import UIKit
import BRYXBanner

class BannerAlert {
    enum BannerType {
        case success
        case error
    }
    
    static func show(title: String, subtitle: String, type: BannerType, duration: TimeInterval = 5) {
        var backgroundColor: UIColor = UIColor.red
        switch type {
        case .error:
            backgroundColor = UIColor.red
        case .success:
            backgroundColor = UIColor.systemGreen
        }
        
        let banner = Banner(title: title, subtitle: subtitle, backgroundColor: backgroundColor)
        banner.dismissesOnTap = true
        banner.show(duration: duration)
    }
    
    static func show(with error: Error?) {
        if let error = error {
            BannerAlert.show(title: "Error", subtitle: error.localizedDescription, type: .error)
        }
    }
    
    static func showUnknownError(functionName: String) {
        BannerAlert.show(title: "Error", subtitle: "There was an error using the \(functionName). Please contact the Ohana team at (401) 474 - 4336 to fix this.", type: .error)
    }
}

struct Helpers {
    static func open(urlString: String) {
        guard let url = URL(string: urlString) else {
            BannerAlert.show(title: "Error", subtitle: "Could not open \(urlString)", type: .error)
            return
        }
        UIApplication.shared.open(url)
    }
    
    static func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        if let keyboardFrame = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            let keyboardHeight = keyboardFrame.height
            return keyboardHeight
        }
        return 0
    }
}
