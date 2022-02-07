//
//  RegisterView.swift
//  lookbook
//
//  Created by Dan Kwun on 2/7/22.
//

import UIKit

class RegisterView: UIView {
    var titleLabel: UILabel!
    private var stackView: UIStackView!
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
        createTextField(placeHolder: "EMAIL")
        createTextField(placeHolder: "PASSWORD")
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
    
    //TODO: maybe use an animated cocoapod for this
    private func createTextField(placeHolder: String) {
        let textField = UITextField()
        textField.placeholder = placeHolder
        textField.borderStyle = .line
        textField.layer.borderWidth = 2
        textField.font = .systemFont(ofSize: 15, weight: .regular)
        textField.autocorrectionType = .no
        textField.autocapitalizationType = .none
        textField.spellCheckingType = .no
        stackView.addArrangedSubview(textField)
        textField.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(50)
        }
    }
}
