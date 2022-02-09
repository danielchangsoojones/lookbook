//
//  CreateProfileViewController.swift
//  lookbook
//
//  Created by Dan Kwun on 2/9/22.
//

import UIKit
import ALCameraViewController

class CreateProfileViewController: RegisterViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    private var profileImageView: UIImageView!
    private var profileCTALabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addProfilePhoto()
        updateLabels()
    }
    
    private func addProfilePhoto() {
        profileImageView = UIImageView()
        profileImageView.backgroundColor = .white
        profileImageView.layer.borderColor = UIColor(red: 255/256, green: 206/256, blue: 72/256, alpha: 1.0).cgColor
        profileImageView.layer.borderWidth = 2
        profileImageView.contentMode = .scaleAspectFit
        profileImageView.layer.cornerRadius = 50
        profileImageView.clipsToBounds = true
        view.addSubview(profileImageView)
        profileImageView.snp.makeConstraints { (make) in
            make.width.height.equalTo(100)
            make.centerX.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
        }
        stackView.snp.remakeConstraints { make in
            make.leading.trailing.equalTo(titleLabel)
            make.top.equalTo(profileImageView.snp.bottom).offset(10)
        }
        profileCTALabel = UILabel()
        profileCTALabel.text = "Click Me!"
        profileImageView.addSubview(profileCTALabel)
        profileCTALabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        profileImageView.addTap(target: self, action: #selector(showPhotoPicker))
    }
    
    @objc private func showPhotoPicker() {
        let imagePicker = UIImagePickerController()
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
            imagePicker.delegate = self
            imagePicker.sourceType = .savedPhotosAlbum
            imagePicker.allowsEditing = false
            present(imagePicker, animated: true, completion: nil)
        }
    }
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            profileImageView.image = image
            profileCTALabel.isHidden = true
        }
        self.dismiss(animated: true, completion: nil)
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
            dataStore.save(name: name, phoneNumber: phoneNumber, photo: profileImageView?.image)
            let tabController = TabBarController()
            tabController.modalPresentationStyle = .fullScreen
            present(tabController, animated: true, completion: nil)
        }
    }
    
    var isComplete: Bool {
        guard let name = emailTextField?.text else {
            return false
        }
        
        guard let phoneStr = passwordTextField?.text else {
            return false
        }
        
        if profileImageView.image == nil {
            BannerAlert.show(title: "Photo Needed", subtitle: "Please upload a photo", type: .error)
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
