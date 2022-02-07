//
//  LogInViewController.swift
//  lookbook
//
//  Created by Dan Kwun on 2/7/22.
//

import UIKit

class LogInViewController: RegisterViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        updateLabels()
    }
    
    private func updateLabels() {
        titleLabel.text = "Log In"
        nextButton.setTitle("LOG IN", for: .normal)
    }
    
    override func nextBtnPressed() {
        print("log in")
    }
}
