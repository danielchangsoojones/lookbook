//
//  CreateProfileViewController.swift
//  lookbook
//
//  Created by Dan Kwun on 2/9/22.
//

import UIKit

class CreateProfileViewController: RegisterViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        updateLabels()
    }
    
    private func updateLabels() {
        titleLabel.text = "👋 Let’s create a profile for you! Only the influencers you chat with will be able to see your name and photo."
        titleLabel.numberOfLines = 0
        titleLabel.font = .systemFont(ofSize: 20, weight: .regular)
        nextButton.setTitle("FINISH", for: .normal)
        emailTextField.placeholder = "Name"
        passwordTextField.placeholder = "Phone Number"
        passwordTextField.isSecureTextEntry = false
        passwordTextField.keyboardType = .decimalPad
        navigationItem.hidesBackButton = true
    }
    
    override func nextBtnPressed() {
        if isComplete {
            let name = emailTextField?.text ?? ""
            let bottomText = passwordTextField?.text ?? "1111111111"
            let phoneNumber = NumberFormatter().number(from: bottomText.numbersOnly)?.doubleValue ?? 1111111111
            dataStore.save(name: name, phoneNumber: phoneNumber)
            let tabController = TabBarController()
            tabController.modalPresentationStyle = .fullScreen
            present(tabController, animated: true, completion: nil)
        }
    }
    
    var isComplete: Bool {
        //TODO: check if profile image filled in
        guard let name = emailTextField?.text else {
            return false
        }

        guard let phoneStr = passwordTextField?.text else {
            return false
        }
        
        if name.isEmpty {
            BannerAlert.show(title: "Name Needed", subtitle: "Please input your name", type: .error)
            return false
        }
        if phoneStr.isEmpty {
            BannerAlert.show(title: "Phone Number Needed", subtitle: "Please input your phone number", type: .error)
            return false
        }
        
        if !phoneStr.isPhoneNumber {
            BannerAlert.show(title: "Invalid Phone Number", subtitle: "A proper phone number has only 9 digits", type: .error)
            return false
        }
        
        return true
    }
}
