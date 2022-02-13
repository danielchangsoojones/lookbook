//
//  MasterChatRoomViewController.swift
//  lookbook
//
//  Created by Dan Kwun on 2/8/22.
//

import UIKit

class MasterChatRoomViewController: UIViewController {
    private var chatRooms: [ChatRoomParse] = []
    private var dataStore = MasterChatDataStore()
    private var tableView: UITableView!
    private var callToActionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        super.loadView()
        let masterChatRoomView = MasterChatRoomView(frame: self.view.frame)
        self.view = masterChatRoomView
        self.tableView = masterChatRoomView.tableView
        self.callToActionLabel = masterChatRoomView.callToActionLabel
        setup(masterChatRoomView.tableView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        loadMasterChatRooms()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    private func setup(_ tableView: UITableView) {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(cellType: MasterChatRoomTableViewCell.self)
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
    }
    
    private func loadMasterChatRooms() {
        let isUserInfluencer = User.current()?.influencer != nil ? true : false
        dataStore.getMasterChatRooms(isUserInfluencer: isUserInfluencer) { chatRooms in
            self.chatRooms = chatRooms
            self.tableView.reloadData()
            self.callToActionLabel.isHidden = chatRooms.count > 0
        }
    }
}

extension MasterChatRoomViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatRooms.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath, cellType: MasterChatRoomTableViewCell.self)
        let chatRoom = chatRooms[indexPath.row]
        
        var profileImage = chatRoom.influencer.user.profilePhoto
        var influencerName = chatRoom.influencer.user.name ?? ""
        var lastMessage = "Send a message!"
        var timeStamp = chatRoom.createdAt?.format() ?? Date().format()
        var hasUnread = false
        
        if let latestMessage = chatRoom.latestMessage {
            lastMessage = latestMessage.message
            timeStamp = latestMessage.createdAt?.format() ?? Date().format()
            hasUnread = latestMessage.hasRead == nil ? true : false
        }
        
        let isUserInfluencer = User.current()?.influencer != nil ? true : false
        if isUserInfluencer {
            profileImage = chatRoom.fan.profilePhoto
            influencerName = chatRoom.fan.name ?? ""
        }
        
        cell.set(imageFile: profileImage,
                 name: influencerName,
                 lastMessage: lastMessage,
                 timeStamp: timeStamp,
                 hasUnread: hasUnread)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let chatRoom = chatRooms[indexPath.row]
        let influencer = chatRoom.influencer
        let fan = chatRoom.fan
        let isUserInfluencer = User.current()?.influencer != nil ? true : false
        if isUserInfluencer {
            //user is influencer
            pushVC(ChatViewController(influencer: nil, fan: fan, isUserInfluencer: true))
        } else {
            pushVC(ChatViewController(influencer: influencer, fan: fan, isUserInfluencer: false))
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
