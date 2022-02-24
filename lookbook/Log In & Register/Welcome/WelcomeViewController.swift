//
//  ViewController.swift
//  lookbook
//
//  Created by Daniel Jones on 1/12/22.
//

import UIKit

class WelcomeViewController: UIViewController {
    private var messageHelper: MessageHelper?
    private var logInButton: UIButton!
    private var registerButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.messageHelper = MessageHelper(currentVC: self, delegate: nil)
        let welcomeView = WelcomeView(frame: self.view.bounds)
        self.view = welcomeView
        logInButton = welcomeView.logInButton
        registerButton = welcomeView.registerButton
        welcomeView.logInButton.addTarget(self, action: #selector(logInPressed), for: .touchUpInside)
        welcomeView.registerButton.addTarget(self, action: #selector(registerPressed), for: .touchUpInside)
        setContactButton()
    }
    
    private func setContactButton() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Contact Us",
            style: .plain,
            target: self,
            action: #selector(contactPressed)
        )
    }
   
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @objc private func contactPressed() {
        messageHelper?.text(MessageHelper.customerServiceNum)
    }
    
    @objc private func logInPressed() {
        let logInVC = LogInViewController()
        navigationController?.pushViewController(logInVC, animated: true)
    }
    
    @objc private func registerPressed() {
        let registerVC = RegisterViewController()
        pushVC(registerVC)
    }
}

