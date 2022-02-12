//
//  BroadcastViewCell.swift
//  lookbook
//
//  Created by Tyler Flowers on 2/11/22.
//

import Foundation
import UIKit
import Reusable

class BroadcastViewCell: MasterChatRoomTableViewCell  {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        unreadCircleView.isHidden = true
        timeStampLabel.isHidden = true
        nameLabel.text = "BROADCAST YOUR MESSAGE"
        setupSpeaker()
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func setUpInfluencerPhoto() {
        super.setUpInfluencerPhoto()
        let broadcastImage = UIImage(named: "broadcastProfile")
        profileImageView.image = broadcastImage
    }
    func setupSpeaker() {
        let speakerImageView = UIImageView()
        let speakerImage = UIImage(named: "speakerphone")
        speakerImageView.image = speakerImage
        speakerImageView.contentMode = .scaleAspectFit
        addSubview(speakerImageView)
        speakerImageView.snp.makeConstraints { make in
            make.trailing.leading.equalTo(unreadCircleView)
            make.top.bottom.equalTo(unreadCircleView)
        }
    }
    
}
