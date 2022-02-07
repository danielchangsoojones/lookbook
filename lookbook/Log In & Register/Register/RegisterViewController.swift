//
//  RegisterViewController.swift
//  lookbook
//
//  Created by Dan Kwun on 2/7/22.
//

import UIKit
import SnapKit

class RegisterViewController: UIViewController {
    var titleLabel: UILabel!
    var emailTextField: UITextField!
    var passwordTextField: UITextField!
    var nextButton: UIButton!
    var dataStore: OnboardingDataStore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let registerView = RegisterView(frame: self.view.bounds)
        self.view = registerView
        titleLabel = registerView.titleLabel
        emailTextField = registerView.emailTextField
        passwordTextField = registerView.passwordTextField
        nextButton = registerView.nextButton
        registerView.nextButton.addTarget(self, action: #selector(nextBtnPressed), for: .touchUpInside)
        navigationController?.navigationBar.tintColor = UIColor.black
        dataStore = OnboardingDataStore()
    }
    
    @objc func nextBtnPressed() {
        //TODO: should feed in the field values
        dataStore.register(email: "dankwun@gmail.com", password: "sup")
    }
}
