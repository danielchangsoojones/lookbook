//
//  MessageHelper.swift
//  lookbook
//
//  Created by Dan Kwun on 2/12/22.
//

import Foundation
import MessageUI

/*
 The MessageHelper must declared as a global variable in any class. This is because the Message Helper
 must be retained even after a function finishes, so it can complete all actions needed for text messaging.
 If the MessageHelper is not retained then you will experience crashes.
*/
class MessageHelper: NSObject {
    var theSpinnerContainer: UIView?
    weak var currentVC: UIViewController?
    var messageDelegate: MFMessageComposeViewControllerDelegate?
    //initializing the messageVC at the start because it takes a little bit of time to load. This makes it better for the user because it pops up quicker because I already had loaded it.
    var messageViewController: MFMessageComposeViewController?
    
    init(currentVC: UIViewController, delegate: MFMessageComposeViewControllerDelegate? = nil) {
        self.messageDelegate = delegate
        self.currentVC = currentVC
        if MFMessageComposeViewController.canSendText() {
            messageViewController = MFMessageComposeViewController()
        }
        super.init()
    }
    
    func text(_ phoneNumber: String, body: String = "") {
        if let currentVC = currentVC {
            theSpinnerContainer = Helpers.showActivityIndicatory(in: currentVC.view)
            Timer.runThisAfterDelay(seconds: 0.01, after: {
                //the spinner was taking a while to show up because sendSMS was somehow taking up the processing, so it felt like the user had not pressed the button. This fixed it.
                self.sendSMSText(phoneNumber: phoneNumber, body: body)
            })
        } else {
            BannerAlert.show(title: "Message Error", subtitle: "For some reason, the currentVC is not existing [Daniel Error 2]", type: .error)
        }
    }
    
    private func sendSMSText(phoneNumber: String, body: String) {
        if (MFMessageComposeViewController.canSendText()) {
            if let messageViewController = messageViewController {
                messageViewController.recipients = phoneNumber == "" ? nil : [phoneNumber]
                messageViewController.body = body
                
                if let messageDelegate = messageDelegate {
                    messageViewController.messageComposeDelegate = messageDelegate
                } else {
                    messageViewController.messageComposeDelegate = self
                }
                
                if currentVC == nil {
                    BannerAlert.show(title: "Message Error", subtitle: "the current VC is nil [Daniel Error 4]", type: .error)
                }
                
                currentVC?.present(messageViewController, animated: true, completion: {
                    self.theSpinnerContainer?.removeFromSuperview()
                })
            } else {
                BannerAlert.show(title: "Message Error", subtitle: "messageViewController is not existing [Daniel Error 3]", type: .error)
            }
        } else {
            theSpinnerContainer?.removeFromSuperview()
            BannerAlert.show(title: "Message Error", subtitle: "Can not send messages currently", type: .error)
        }
    }
}

extension MessageHelper: MFMessageComposeViewControllerDelegate {
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        switch result {
        case .sent:
            //the controller dismisses better without an animation when the message has actually been sent. I'm not sure why.
            controller.dismiss(animated: false, completion: nil)
            BannerAlert.show(title: "Text Message Sent", subtitle: "", type: .success)
        case .cancelled:
            controller.dismiss(animated: true, completion: nil)
        case .failed:
            controller.dismiss(animated: true, completion: nil)
            BannerAlert.show(title: "Message Error", subtitle: "Error sending text message", type: .error)
        @unknown default:
            BannerAlert.show(title: "Error", subtitle: "recevied unrecognized message compose status", type: .error)
        }
        
        reset()
    }
    
    private func reset() {
        messageViewController = MFMessageComposeViewController()
    }
}
