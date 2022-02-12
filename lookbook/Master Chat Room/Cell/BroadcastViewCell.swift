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
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func setUpInfluencerPhoto() {
        super.setUpInfluencerPhoto()
        let broadcastImage = UIImage(named: "broadcastProfile")
        profileImageView.image = broadcastImage
    }
    func setupThumbnail() {
        let thumbnailImage = UIImage(named: "thumbnail")
        let myImageView: UIImageView = UIImageView(image: thumbnailImage)
        myImageView.contentMode = .scaleAspectFit
        addSubview(myImageView)
        myImageView.snp.makeConstraints { make in
            make.leading.trailing.equalTo(unreadCircleView)
            make.top.bottom.equalTo(unreadCircleView)
    }
    }
    
}
