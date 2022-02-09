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
        setUpResetPasswordBtn()
    }
    
    override func nextBtnPressed() {
        if validateEmail() && validatePassword() {
            dataStore.logIn(email: emailTextField.text ?? "",
                            password: passwordTextField.text ?? "")
        }
    }
    
    private func updateLabels() {
        titleLabel.text = "Log In"
        nextButton.setTitle("LOG IN", for: .normal)
    }
    
    private func setUpResetPasswordBtn() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "Reset Password",
            style: .plain,
            target: self,
            action: #selector(resetBtnPressed)
        )
        navigationItem.rightBarButtonItem?.setTitleTextAttributes([ .font: UIFont.systemFont(ofSize: 13, weight: .light)], for: .normal)
    }
    
    @objc private func resetBtnPressed() {
        let resetPasswordVC = ResetPasswordViewController()
        pushVC(resetPasswordVC)
    }
    
    override func segueIntoApp() {
        let tabController = TabBarController()
        tabController.modalPresentationStyle = .fullScreen
        present(tabController, animated: true, completion: nil)
    }
}
