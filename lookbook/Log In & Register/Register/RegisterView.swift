//
//  RegisterView.swift
//  lookbook
//
//  Created by Dan Kwun on 2/7/22.
//

import UIKit
import TextFieldEffects

class RegisterView: UIView {
    var titleLabel: UILabel!
    private var stackView: UIStackView!
    var emailTextField: UITextField!
    var passwordTextField: UITextField!
    var nextButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setUpTitleLabel()
        setUpStackView()
        setUpStackViewContent()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpTitleLabel() {
        titleLabel = UILabel()
        titleLabel.text = "Register"
        titleLabel.font = .systemFont(ofSize: 36, weight: .regular)
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.equalTo(self.snp.topMargin).inset(30)
        }
    }
    
    private func setUpStackView() {
        stackView = UIStackView()
        stackView.spacing = 15
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .center
        addSubview(stackView)
        stackView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp.bottom).offset(30)
        }
    }
    
    private func setUpStackViewContent() {
        emailTextField = createTextField(placeHolder: "EMAIL")
        passwordTextField = createTextField(placeHolder: "PASSWORD")
        setUpNextButton()
    }
    
    private func setUpNextButton() {
        nextButton = UIButton()
        nextButton.backgroundColor = .black
        nextButton.titleLabel?.textColor = .white
        nextButton.setTitle("REGISTER", for: .normal)
        nextButton.titleLabel?.font =  .systemFont(ofSize: 13, weight: .black)
        nextButton.layer.cornerRadius = 8
        nextButton.clipsToBounds = true
        stackView.addArrangedSubview(nextButton)
        nextButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(50)
        }
    }
    
    private func createTextField(placeHolder: String) -> UITextField {
        let textField = HoshiTextField()
        textField.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        textField.borderActiveColor = .black
        textField.borderInactiveColor = UIColor.black.withAlphaComponent(0.5)
        textField.textColor = .black
        textField.placeholder = placeHolder
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.spellCheckingType = .no
        stackView.addArrangedSubview(textField)
        textField.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(60)
        }
        
        return textField
    }
}
