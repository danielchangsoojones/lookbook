//
//  ViewController.swift
//  lookbook
//
//  Created by Daniel Jones on 1/12/22.
//

import UIKit

class WelcomeViewController: UIViewController {
    private var logInButton: UIButton!
    private var registerButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let welcomeView = WelcomeView(frame: self.view.bounds)
        self.view = welcomeView
        logInButton = welcomeView.logInButton
        registerButton = welcomeView.registerButton
        welcomeView.logInButton.addTarget(self, action: #selector(logInPressed), for: .touchUpInside)
        welcomeView.registerButton.addTarget(self, action: #selector(registerPressed), for: .touchUpInside)
    }
   
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    @objc private func logInPressed() {
        print("log in")
    }
    
    @objc private func registerPressed() {
        let registerVC = RegisterViewController()
        navigationController?.pushViewController(registerVC, animated: true)
    }
}

