//
//  ResetPasswordViewController.swift
//  lookbook
//
//  Created by Dan Kwun on 2/7/22.
//

import UIKit

class ResetPasswordViewController: RegisterViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = "Forgot Password"
        nextButton.setTitle("EMAIL RESET LINK", for: .normal)
        updateView()
    }
    
    private func updateView() {
        passwordTextField.isHidden = true
    }
    
    override func nextBtnPressed() {
        if validateEmail(), let email = emailTextField?.text?.lowercased() {
            dataStore.resetPassword(email: email) { success in
                if success {
                    self.nextButton.setTitle("Link Sent", for: .normal)
                    self.nextButton.backgroundColor = .systemGreen
                }
            }
            
        } else {
            BannerAlert.show(title: "Invalid Email", subtitle: "Please enter a valid email.", type: .error)
        }
    }
}
