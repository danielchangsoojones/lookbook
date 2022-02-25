//
//  MessengerViewController.swift
//  lookbook
//
//  Created by Daniel Jones on 2/8/22.
//

import UIKit
import SnapKit

class ChatViewController: UIViewController {
    var collectionView: UICollectionView!
    private let backgroundImgView = UIImageView()
    private let backgroundGradient = CAGradientLayer()
    var inputChatView = InputChatView()
    private var fan: User!
    private let influencer: InfluencerParse
    var chatMessages: [ChatMessage] = []
    var sendMessageButton: UIButton!
    var dataStore = MessengerDataStore()
    private var bottomConstraint: Constraint?
    private var hasUserReachedLimit: Bool?
    
    var isUserInfluencer: Bool {
        return Influencer.shared != nil
    }
    
    init(influencer: InfluencerParse, fan: User) {
        self.influencer = influencer
        self.fan = fan
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        setBackgroundImg()
        setInputView()
        setupCollectionView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
        collectionView.reloadData()
        setKeyboardDetector()
        checkPushNotificationStatus()
    }
    
    private func setKeyboardDetector() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
        tabBarController?.tabBar.isHidden = true
        navigationController?.navigationBar.tintColor = UIColor.black
        if isUserInfluencer {
            self.title = fan.name ?? ""
        } else {
            self.title = influencer.user.name ?? ""
        }
        loadMessages()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.tabBarController?.tabBar.isHidden = false
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        backgroundGradient.frame = backgroundImgView.bounds
        scrollToLastMessage()
    }
    
    private func checkPushNotificationStatus() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if let error = error {
                // Handle the error here.
                BannerAlert.show(with: error)
            }
        }
        
        let current = UNUserNotificationCenter.current()
        current.getNotificationSettings(completionHandler: { permission in
            switch permission.authorizationStatus  {
            case .authorized:
                print("User granted permission for notification")
            case .denied:
                DispatchQueue.main.async {
                    BannerAlert.show(title: "Enable Push Notifications", subtitle: "To see when you receive new messages from this celeb, please go to your iPhone settings and enable push notifications", type: .info)
                }
            case .notDetermined:
                print("push notifications are not determined yet")
            case .provisional:
                // @available(iOS 12.0, *)
                print("The application is authorized to post non-interruptive user notifications.")
            case .ephemeral:
                // @available(iOS 14.0, *)
                print("The application is temporarily authorized to post notifications. Only available to app clips.")
            @unknown default:
                print("Unknow Status")
            }
        })
    }
    
    func loadMessages() {
        dataStore.loadMessages(fanId: fan.objectId ?? "", influencerID: influencer.objectId ?? "", isUserInfluencer: isUserInfluencer, lastMsgTimeStamp: nil) { messages, hasUserReachedLimit in
            //TODO: we then need to save the values in a static var
            self.chatMessages = messages
            self.hasUserReachedLimit = hasUserReachedLimit
            if hasUserReachedLimit {
                self.showSubscriptionModalVC(influencer: self.influencer)
            }
            self.collectionView.reloadData()
            self.scrollToLastMessage()
        }
    }
    
    private func setBackgroundImg() {
        view.backgroundColor = .white
        let image = influencer.chatBackgroundPhoto
        if image == nil {
            backgroundImgView.image = UIImage(named: "welcome_bg")
        } else {
            backgroundImgView.loadFromFile(image)
            backgroundImgView.contentMode = .scaleAspectFill
            backgroundGradient.colors = [
                UIColor(red: 0, green: 0, blue: 0, alpha: 0.8).cgColor,
                UIColor(red: 0.769, green: 0.769, blue: 0.769, alpha: 0.48).cgColor,
                UIColor(red: 0.769, green: 0.769, blue: 0.769, alpha: 0.32).cgColor
            ]
            backgroundImgView.layer.insertSublayer(backgroundGradient, at: 0)
        }
        backgroundImgView.clipsToBounds = true
        view.addSubview(backgroundImgView)
        backgroundImgView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(self.view.snp.topMargin)
        }
    }
    
    private func setupCollectionView() {
        let frame = CGRect(x: 0,
                           y: 0,
                           width: self.view.frame.width,
                           height: self.view.frame.height)
        let layout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(cellType: ChatTextCollectionCell.self)
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.top.equalTo(view.snp.topMargin)
            make.bottom.equalTo(inputChatView.snp.top)
        }
    }
    
    private func setInputView() {
        sendMessageButton = inputChatView.sendButton
        sendMessageButton.addTarget(self, action: #selector(pressedSendBtn), for: .touchUpInside)
        view.addSubview(inputChatView)
        inputChatView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            self.bottomConstraint = make.bottom.equalToSuperview().constraint
        }
    }
    
    @objc private func handleKeyboardNotification(notification: NSNotification) {
        let keyboardHeight = Helpers.getKeyboardHeight(notification: notification)
        let isKeyboardShowing = notification.name == UIResponder.keyboardWillShowNotification
        if isKeyboardShowing {
            bottomConstraint?.update(offset: -keyboardHeight)
            inputChatView.bottomConstraint?.update(offset: -inputChatView.topOffset)
        } else {
            bottomConstraint?.update(offset: 0)
            inputChatView.bottomConstraint?.update(offset: -inputChatView.originalBottomConstraint)
        }
        
        UIView.animate(withDuration: 0,
                       delay: 0,
                       options: .curveEaseOut) {
            self.view.layoutIfNeeded()
        } completion: { _ in}
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        let keyboardHeight = Helpers.getKeyboardHeight(notification: notification)
        bottomConstraint?.update(offset: -keyboardHeight)
        UIView.animate(withDuration: 0, delay: 0, options: UIView.AnimationOptions.curveEaseOut) {
            self.view.layoutIfNeeded()
        } completion: { (completed) in
            self.scrollToLastMessage()
        }
    }
    
    func scrollToLastMessage() {
        let indexPath = NSIndexPath(item: self.chatMessages.count - 1, section: 0) as IndexPath
        self.collectionView?.scrollToItem(at: indexPath, at: .bottom, animated: true)
    }
    
    @objc private func pressedSendBtn() {
        if let localMessage = inputChatView.textView.text, !localMessage.isEmpty {
            if hasUserReachedLimit ?? false {
                //show subscription screen
                showSubscriptionModalVC(influencer: influencer)
            } else {
                //show message
                startSendMessageAction(localMessage: localMessage)
            }
        }
    }
    
    private func startSendMessageAction(localMessage: String) {
        let newLocalMsg = ChatMessage(messageParse: nil, isSenderInfluencer: isUserInfluencer, localMsg: localMessage)
        chatMessages.append(newLocalMsg)
        //TODO: we just need to insert this at the bottom instead of reloading
        collectionView.reloadData()
        scrollToLastMessage()
        inputChatView.textView.text = ""
        let fanID = fan?.objectId ?? ""
        //TODO: this isn't entirely accurate as some of the influencer's messages might be a DM. We need to check if this room is a broadcast channel.
        let messageType = "DM"
        dataStore.sendMessage(fanId: fanID,
                              influencer: influencer,
                              isUserInfluencer: self.isUserInfluencer,
                              messageText: localMessage,
                              messageType: messageType) { chatRoomParse in
            self.chatMessages.last?.messageParse = chatRoomParse.latestMessage
            print("succesfully ran sendMessage")
        }
    }
}

extension ChatViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    //TODO: once data store function is hooked up, replace testMessages with messages
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return chatMessages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let message = chatMessages[indexPath.row]
        let cell = collectionView.dequeueReusableCell(for: indexPath,
                                                         cellType: ChatTextCollectionCell.self)
        let chatMessageParse = message.messageParse
        let messageText = chatMessageParse?.message ?? (message.localMsg ?? "")
        let timeStamp = chatMessageParse?.createdAt?.format() ?? Date().format()
        var messageProfileImage = User.current()?.profilePhoto
        if isUserInfluencer {
            if let chatMessageParse = chatMessageParse, !message.isSenderInfluencer {
                //we do not want any profile image when the sender was influencer
                //it was crashing on the message just sent, even though it doesn't need a profile
                //photo for a sent message
                messageProfileImage = chatMessageParse.fan.profilePhoto
            }
        } else {
            messageProfileImage = influencer.user.profilePhoto
        }
        cell.set(profileImage: messageProfileImage,
                 message: messageText,
                 time: timeStamp)
        let estimatedFrame = getMsgFrame(message: messageText)
        let padding: CGFloat = 20
        let horizontalPadding: CGFloat = 16
        let startingInternalPadding: CGFloat = 8
        let profileImgOffset: CGFloat = cell.profileImageView.frame.width + 15
        
        if isUserInfluencer {
            //user is influencer
            if message.isSenderInfluencer {
                //show influencer's message in blue on right
                showOutboundMessages(cell: cell, estimatedFrame: estimatedFrame, horizontalPadding: horizontalPadding, startingInternalPadding: startingInternalPadding, padding: padding)
            } else {
                //show fan's messages in white on left
                showInboundMessage(cell: cell, estimatedFrame: estimatedFrame, horizontalPadding: horizontalPadding, startingInternalPadding: startingInternalPadding, padding: padding, profileImgOffset: profileImgOffset)
            }
        } else {
            //user is fan
            if message.isSenderInfluencer {
                //show influencer's messages in white on left
                showInboundMessage(cell: cell, estimatedFrame: estimatedFrame, horizontalPadding: horizontalPadding, startingInternalPadding: startingInternalPadding, padding: padding, profileImgOffset: profileImgOffset)
            } else {
                //show fan's message in blue on right
                showOutboundMessages(cell: cell, estimatedFrame: estimatedFrame, horizontalPadding: horizontalPadding, startingInternalPadding: startingInternalPadding, padding: padding)
            }
        }
        
        return cell
    }
    
    private func showInboundMessage(cell: ChatTextCollectionCell, estimatedFrame: CGRect, horizontalPadding: CGFloat, startingInternalPadding: CGFloat, padding: CGFloat, profileImgOffset: CGFloat) {
        cell.profileImageView.isHidden = false
        cell.bubbleView.backgroundColor = .white
        cell.messageTextView.textColor = .black
        cell.bubbleView.frame = CGRect(x: profileImgOffset,
                                       y: 0,
                                       width: estimatedFrame.width + horizontalPadding + startingInternalPadding,
                                       height: estimatedFrame.height + padding)
        cell.messageTextView.frame = CGRect(x: startingInternalPadding + profileImgOffset,
                                            y: 0,
                                            width: estimatedFrame.width + horizontalPadding,
                                            height: estimatedFrame.height + padding)
        cell.timeLabel.snp.remakeConstraints { make in
            make.bottom.equalTo(cell.bubbleView)
            make.leading.equalTo(cell.bubbleView.snp.trailing).offset(3)
        }
    }
    
    private func showOutboundMessages(cell: ChatTextCollectionCell, estimatedFrame: CGRect, horizontalPadding: CGFloat, startingInternalPadding: CGFloat, padding: CGFloat) {
        cell.profileImageView.isHidden = true
        cell.bubbleView.backgroundColor = UIColor(red: 16/256, green: 121/256, blue: 249/256, alpha: 1)
        cell.messageTextView.textColor = .white
        cell.bubbleView.frame = CGRect(x: view.frame.width - estimatedFrame.width - horizontalPadding - startingInternalPadding - 10,
                                       y: 0,
                                       width: estimatedFrame.width + horizontalPadding + startingInternalPadding,
                                       height: estimatedFrame.height + padding)
        cell.messageTextView.frame = CGRect(x: view.frame.width - estimatedFrame.width - horizontalPadding - 10,
                                            y: 0,
                                            width: estimatedFrame.width + horizontalPadding,
                                            height: estimatedFrame.height + padding)
   
        cell.timeLabel.snp.remakeConstraints { make in
            make.bottom.equalTo(cell.bubbleView)
            make.trailing.equalTo(cell.bubbleView.snp.leading).offset(-3)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let message = chatMessages[indexPath.row]
        let messageText = message.messageParse?.message ?? (message.localMsg ?? "")
        let estimatedFrame = getMsgFrame(message: messageText)
        let padding: CGFloat = 20 + 5
        return CGSize(width: view.frame.width, height: estimatedFrame.height + padding)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        //the start of the messages in the top chat has a nice little inset.
        return UIEdgeInsets(top: 8, left: 0, bottom: 0, right: 0)
    }
    
    private func getMsgFrame(message: String) -> CGRect {
        // This is the max width of the message, not sure why height is 1000
        let maxWidth = view.frame.width * 0.6
        let size = CGSize(width: maxWidth, height: 1000)
        // Not sure what options does
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        // Estimating Height of Text
        let estimatedFrame = NSString(string: message).boundingRect(with: size,
                                                                    options: options,
                                                                    attributes: [NSAttributedString.Key.font : UIFont.systemFont(ofSize: 16)],
                                                                    context: nil)
        return estimatedFrame
    }
    
    //TODO: use this function when we need to show subscription screen
    private func showSubscriptionModalVC(influencer: InfluencerParse) {
        let subscriptionModalVC = SubscriptionModalViewController(influencer: influencer)
        subscriptionModalVC.modalPresentationStyle = .popover
        present(subscriptionModalVC, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        inputChatView.textView.endEditing(true)
    }
}
