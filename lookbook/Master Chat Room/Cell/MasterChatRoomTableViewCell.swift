//
//  MasterChatRoomTableViewCell.swift
//  lookbook
//
//  Created by Dan Kwun on 2/8/22.
//

import UIKit
import Reusable

class MasterChatRoomTableViewCell: UITableViewCell, Reusable {
    var profileImageView: UIImageView!
    var nameLabel: UILabel!
    var timeStampLabel: UILabel!
    private var lastMessageLabel: UILabel!
    var unreadCircleView: UIView!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .white
        setUpInfluencerPhoto()
        setUpNameLabel()
        setUpTimeStampLabel()
        setUpLastMessageLabel()
        setUpUnreadCircleView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        resetImg()
    }
    
    func resetImg() {
        profileImageView.image = nil
    }
    
    func set(imageFile: AnyObject?, name: String, lastMessage: String, timeStamp: String, hasUnread: Bool) {
        profileImageView.loadFromFile(imageFile)
        nameLabel.text = name
        lastMessageLabel.text = lastMessage
        timeStampLabel.text = timeStamp
        unreadCircleView.isHidden = !hasUnread
    }

    func setUpInfluencerPhoto() {
        profileImageView = UIImageView()
        profileImageView.contentMode = .scaleAspectFit
        profileImageView.layer.cornerRadius = 32
        profileImageView.clipsToBounds = true
        contentView.addSubview(profileImageView)
        profileImageView.snp.makeConstraints { (make) in
            make.leading.equalToSuperview()
            make.top.bottom.equalToSuperview().inset(5)
            make.width.height.equalTo(64)
        }
    }
    
    private func setUpNameLabel() {
        nameLabel = UILabel()
        nameLabel.font = .systemFont(ofSize: 13, weight: .bold)
        nameLabel.textAlignment = .left
        contentView.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.leading.equalTo(profileImageView.snp.trailing).offset(15)
            make.bottom.equalTo(profileImageView.snp.centerY).offset(-2.5)
        }
    }
    
    func setUpTimeStampLabel() {
        timeStampLabel = UILabel()
        timeStampLabel.font = .systemFont(ofSize: 11, weight: .regular)
        timeStampLabel.textAlignment = .right
        contentView.addSubview(timeStampLabel)
        timeStampLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.bottom.equalTo(nameLabel.snp.bottom)
            make.leading.equalTo(nameLabel.snp.trailing)
        }
    }
    

    private func setUpLastMessageLabel() {
        lastMessageLabel = UILabel()
        lastMessageLabel.font = .systemFont(ofSize: 13, weight: .regular)
        lastMessageLabel.textAlignment = .left
        contentView.addSubview(lastMessageLabel)
        lastMessageLabel.snp.makeConstraints { make in
            make.leading.equalTo(nameLabel.snp.leading)
            make.trailing.equalTo(timeStampLabel.snp.leading)
            make.top.equalTo(nameLabel.snp.bottom).offset(5)
        }
    }
    
    func setUpUnreadCircleView() {
        unreadCircleView = UIView()
        unreadCircleView.isHidden = false
        unreadCircleView.layer.cornerRadius = 7.5
        unreadCircleView.backgroundColor = .red
        contentView.addSubview(unreadCircleView)
        unreadCircleView.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.centerY.equalTo(lastMessageLabel.snp.centerY)
            make.width.height.equalTo(15)
        }
    }
}
