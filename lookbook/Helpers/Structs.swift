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
    
    static func showActivityIndicatory(in uiView: UIView) -> UIView {
        let container: UIView = UIView()
        container.frame = uiView.frame
        container.center = uiView.center
        container.backgroundColor = UIColor.gray.withAlphaComponent(0.5)
        
        let loadingView: UIView = UIView()
        loadingView.frame = CGRect(x: 0.0, y: 0.0, width: 80.0, height: 80.0)
        loadingView.center = uiView.center
        loadingView.backgroundColor = UIColor(red: 64/256, green: 64/256, blue: 64/256, alpha: 0.7)
        loadingView.clipsToBounds = true
        loadingView.layer.cornerRadius = 10
        
        let actInd: UIActivityIndicatorView = UIActivityIndicatorView()
        actInd.frame = CGRect(x: 0.0, y: 0.0, width: 40.0, height: 40.0)
        actInd.style =
            UIActivityIndicatorView.Style.whiteLarge
        actInd.center = CGPoint(x: loadingView.frame.size.width / 2, y: loadingView.frame.size.height / 2)
        loadingView.addSubview(actInd)
        container.addSubview(loadingView)
        uiView.addSubview(container)
        actInd.startAnimating()
        
        return container
    }
}
