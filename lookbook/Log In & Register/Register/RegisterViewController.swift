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
    var nextButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let registerView = RegisterView(frame: self.view.bounds)
        self.view = registerView
        titleLabel = registerView.titleLabel
        nextButton = registerView.nextButton
        registerView.nextButton.addTarget(self, action: #selector(nextBtnPressed), for: .touchUpInside)
        navigationController?.navigationBar.tintColor = UIColor.black
    }
    
    @objc func nextBtnPressed() {
        print("register")
    }
}
