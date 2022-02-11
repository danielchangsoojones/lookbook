//
//  InfluencerTableViewCell.swift
//  lookbook
//
//  Created by Dan Kwun on 2/7/22.
//

import UIKit
import Reusable

class InfluencerTableViewCell: UITableViewCell, Reusable {
    private var profileImageView: UIImageView!
    var chatButton: UIButton!
    var nameLabel: UILabel!
    var messageCountLabel: UILabel!
    var startChattingAction: (() -> Void)? = nil
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .white
        setUpInfluencerPhoto()
        setUpChatButton()
        setUpInfluencerDescription()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        profileImageView.image = nil
    }
    
    func set(imageFile: AnyObject?, name: String, messageCount: String) {
        nameLabel.text = name
        //TODO: will need to query the Messages table to get # of messages sent. But will start with a default of 3,000
        messageCountLabel.text = "3K"
        profileImageView.loadFromFile(imageFile)
    }
    
    private func setUpInfluencerPhoto() {
        profileImageView = UIImageView()
        profileImageView.contentMode = .scaleAspectFit
        profileImageView.layer.cornerRadius = 30
        profileImageView.clipsToBounds = true
        contentView.addSubview(profileImageView)
        let imageDimension = UIScreen.main.bounds.width - 40
        profileImageView.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
            make.width.height.equalTo(imageDimension)
        }
    }
    
    private func setUpChatButton() {
        if let image = UIImage(named: "chat_button")?.withRenderingMode(.alwaysTemplate) {
            chatButton = UIButton()
            chatButton.addTarget(self, action: #selector(chatButtonPressed), for: .touchUpInside)
            chatButton.setTitle("Start Chatting", for: .normal)
            chatButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .medium)
            chatButton.backgroundColor = .black
            chatButton.layer.cornerRadius = 24
            chatButton.layer.borderWidth = 3
            chatButton.layer.borderColor = UIColor.white.cgColor
            contentView.addSubview(chatButton)
            chatButton.contentEdgeInsets = UIEdgeInsets(top: 14, left: -10, bottom: 14, right: 0)
            chatButton.setImage(image, for: .normal)
            chatButton.tintColor = .white
            chatButton.imageView?.contentMode = .scaleAspectFit
            chatButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -20)
            chatButton.semanticContentAttribute = .forceRightToLeft
            chatButton.snp.makeConstraints { make in
                make.leading.trailing.equalToSuperview().inset(15)
                make.bottom.equalTo(profileImageView.snp.bottom).inset(30)
            }
        }
    }
    
    @objc private func chatButtonPressed() {
        startChattingAction?()
    }
    
    private func setUpInfluencerDescription() {
        nameLabel = UILabel()
        nameLabel.font = .systemFont(ofSize: 16, weight: .bold)
        contentView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview()
            make.top.equalTo(profileImageView.snp.bottom).offset(5)
        }
        
        let subtitleLabel = UILabel()
        subtitleLabel.text = "Messages Sent"
        subtitleLabel.font = .systemFont(ofSize: 13, weight: .regular)
        contentView.addSubview(subtitleLabel)
        subtitleLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview()
            make.top.equalTo(nameLabel.snp.bottom).offset(5)
            make.bottom.equalToSuperview().inset(10)
        }
        
        messageCountLabel = UILabel()
        messageCountLabel.font = .systemFont(ofSize: 13, weight: .bold)
        contentView.addSubview(messageCountLabel)
        messageCountLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(subtitleLabel.snp.trailing).offset(3)
            make.top.bottom.equalTo(subtitleLabel)
            let checkImage = UIImage(named: "verificationCheck")
            let myImageView: UIImageView = UIImageView(image: checkImage)
            myImageView.contentMode = .scaleAspectFit
            addSubview(myImageView)
            myImageView.snp.makeConstraints { make in
                make.leading.equalTo(nameLabel.snp.trailing).offset(3)
                make.top.bottom.equalTo(nameLabel)
            }
        }
    }
}
