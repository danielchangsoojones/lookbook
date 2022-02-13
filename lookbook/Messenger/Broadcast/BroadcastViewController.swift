//
//  BroadcastViewController.swift
//  lookbook
//
//  Created by Dan Kwun on 2/13/22.
//

import UIKit

class BroadcastViewController: ChatViewController {
    private var sendBroadcastButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.title = "BROADCAST CHANNEL"
        updateInputChatView()
    }
    
    override func loadMessages() {
        dataStore.loadBroadcastMessages { broadcastMessages, numberOfFans in
            self.chatMessages = broadcastMessages
            self.collectionView.reloadData()
            self.sendBroadcastButton.setTitle("Broadcast Message to \(Int(numberOfFans)) Fans", for: .normal)
            self.scrollToLastMessage()
        }
    }
    
    private func updateInputChatView() {
        sendBroadcastButton = UIButton()
        sendBroadcastButton.addTarget(self, action: #selector(sendBroadcastButtonPressed), for: .touchUpInside)
        sendBroadcastButton.setTitle("Broadcast Message", for: .normal)
        sendBroadcastButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        sendBroadcastButton.backgroundColor = .black
        sendBroadcastButton.layer.cornerRadius = 24
        sendBroadcastButton.layer.borderWidth = 3
        sendBroadcastButton.layer.borderColor = UIColor.white.cgColor
        inputChatView.addSubview(sendBroadcastButton)
        sendBroadcastButton.contentEdgeInsets = UIEdgeInsets(top: 14, left: -10, bottom: 14, right: 0)
        sendBroadcastButton.tintColor = .white
        sendBroadcastButton.imageView?.contentMode = .scaleAspectFit
        sendBroadcastButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: -20)
        sendBroadcastButton.semanticContentAttribute = .forceRightToLeft
        sendBroadcastButton.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(10)
            make.bottom.equalToSuperview().inset(8)
        }
        
        sendMessageButton.isHidden = true
        let textView = inputChatView.textView
        textView.snp.remakeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(10)
            make.top.equalToSuperview().inset(8)
            make.bottom.equalTo(sendBroadcastButton.snp.top).offset(-3)
        }
    }
    
    @objc private func sendBroadcastButtonPressed() {
        if let localMessage = inputChatView.textView.text, !localMessage.isEmpty {
            let newLocalMsg = ChatMessage(messageParse: nil, isSenderInfluencer: true, localMsg: localMessage)
            chatMessages.append(newLocalMsg)
            //TODO: we just need to insert this at the bottom instead of reloading
            collectionView.reloadData()
            scrollToLastMessage()
            inputChatView.textView.text = ""
            dataStore.sendBroadcast(messageText: localMessage) {
                print("hi")
            }
        }
    }
}
