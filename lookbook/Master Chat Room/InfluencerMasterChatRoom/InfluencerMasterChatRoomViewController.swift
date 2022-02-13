//
//  InfluencerMasterChatRoomViewController.swift
//  lookbook
//
//  Created by Dan Kwun on 2/12/22.
//

import UIKit

class InfluencerMasterChatRoomViewController: MasterChatRoomViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatRooms.count + 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.row == 0) {
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: BroadcastViewCell.self)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(for: indexPath, cellType: MasterChatRoomTableViewCell.self)
            let chatRoom = chatRooms[indexPath.row - 1]
            let profileImage = chatRoom.fan.profilePhoto
            let influencerName = chatRoom.fan.name ?? ""
            var lastMessage = "Send a message!"
            var timeStamp = Date().format()
            var hasUnread = false
            if let latestMessage = chatRoom.latestMessage {
                lastMessage = latestMessage.message
                timeStamp = latestMessage.createdAt?.format() ?? Date().format()
                hasUnread = latestMessage.hasRead == nil ? true : false
            }
            cell.set(imageFile: profileImage,
                     name: influencerName,
                     lastMessage: lastMessage,
                     timeStamp: timeStamp,
                     hasUnread: hasUnread)
            cell.selectionStyle = .none
            return cell
        }
    }
     
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var indexPathRow = indexPath.row
        if indexPathRow != 0 {
            indexPathRow -= 1
        }
        
        let chatRoom = chatRooms[indexPathRow]
        let fan = chatRoom.fan
        
        if indexPathRow == 0 {
            pushVC(ChatViewController(influencer: nil, fan: fan, isUserInfluencer: true))
        } else {
            pushVC(ChatViewController(influencer: nil, fan: fan, isUserInfluencer: true))
        }
    }
}
