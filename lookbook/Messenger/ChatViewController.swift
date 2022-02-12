//
//  MessengerViewController.swift
//  lookbook
//
//  Created by Daniel Jones on 2/8/22.
//

import UIKit
import SnapKit

class ChatViewController: UIViewController {
    struct TestMessage {
        let message: String
        let isSenderCeleb: Bool
        var messageParse: MessageParse? = nil
    }
    private var collectionView: UICollectionView!
    private let backgroundImgView = UIImageView()
    private let backgroundGradient = CAGradientLayer()
    private let inputChatView = InputChatView()
    private var fan: User!
    private var influencer: InfluencerParse?
    private var isUserInfluencer: Bool!
    private var testMessages: [ChatMessage]!
    private var messages: [MessageParse] = []
    private var sendMessageButton: UIButton!
    private var dataStore = MessengerDataStore()
    private var bottomConstraint: Constraint?
    private func populateMessageArray() {
        testMessages = [
            ChatMessage(messageParse: nil, isSenderInfluencer: true, localMsg: " hey this is daniel what's up hows it going ehllo blahblah ?"),
            ChatMessage(messageParse: nil, isSenderInfluencer: true, localMsg: "hey this is dk wlbha lkajdfl alkjds falksjd flkj ?"),
            ChatMessage(messageParse: nil, isSenderInfluencer: true, localMsg: "i like to eat alkjda flkajsd flakjsd flakjd f"),
            ChatMessage(messageParse: nil, isSenderInfluencer: true, localMsg: "that's really cool woahalkdjf alksdjf "),
            ChatMessage(messageParse: nil, isSenderInfluencer: true, localMsg: "did you type this out "),
            ChatMessage(messageParse: nil, isSenderInfluencer: false, localMsg: "cool"),
            ChatMessage(messageParse: nil, isSenderInfluencer: false, localMsg: "beans dlfkajsdl fkja"),
            ChatMessage(messageParse: nil, isSenderInfluencer: false, localMsg: "yayayyay aya ya y aya y aya "),
            ChatMessage(messageParse: nil, isSenderInfluencer: false, localMsg: "huelllo``?"),
            ChatMessage(messageParse: nil, isSenderInfluencer: false, localMsg: "yeeettttt"),
            ChatMessage(messageParse: nil, isSenderInfluencer: false, localMsg: "letss get ittt"),
            ChatMessage(messageParse: nil, isSenderInfluencer: false, localMsg: "DOMGOADKLFAJDSF"),
            ChatMessage(messageParse: nil, isSenderInfluencer: false, localMsg: "LETS DO ITSSS"),
            ChatMessage(messageParse: nil, isSenderInfluencer: false, localMsg: "hahhaha"),
            ChatMessage(messageParse: nil, isSenderInfluencer: false, localMsg: "nice1! 😄"),
            ChatMessage(messageParse: nil, isSenderInfluencer: false, localMsg: "hwoo "),
            ChatMessage(messageParse: nil, isSenderInfluencer: false, localMsg: "hi?"),
        ]
    }
    
    init(influencer: InfluencerParse?, fan: User, isUserInfluencer: Bool) {
        self.influencer = influencer
        self.fan = fan
        self.isUserInfluencer = isUserInfluencer
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
        populateMessageArray() //TODO: DELETE & LOAD FROM MESSAGES
        setKeyboardDetector()
    }
    
    private func setKeyboardDetector() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        hideKeyboardWhenTappedAround()
    }
    
    private func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(keyboardWillHide))
        tap.cancelsTouchesInView = false
        collectionView.addGestureRecognizer(tap)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
        tabBarController?.tabBar.isHidden = true
        navigationController?.navigationBar.tintColor = UIColor.black
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
    }
    
    private func loadMessages() {
//        dataStore.loadMessages(influencerObjectId: influencer.objectId ?? "", completion: { messages in
//            self.messages = messages
//            self.collectionView.reloadData()
//        })
    }
    
    private func setBackgroundImg() {
        view.backgroundColor = .white
        if let image = influencer?.chatBackgroundPhoto {
            backgroundImgView.loadFromFile(image)
            backgroundImgView.contentMode = .scaleAspectFill
        }
        view.addSubview(backgroundImgView)
        backgroundImgView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.top.equalTo(self.view.snp.topMargin)
        }
        
        backgroundGradient.colors = [
            UIColor(red: 0, green: 0, blue: 0, alpha: 0.8).cgColor,
            UIColor(red: 0.769, green: 0.769, blue: 0.769, alpha: 0.48).cgColor,
            UIColor(red: 0.769, green: 0.769, blue: 0.769, alpha: 0.32).cgColor
        ]
        backgroundImgView.layer.insertSublayer(backgroundGradient, at: 0)
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
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        let keyboardHeight = Helpers.getKeyboardHeight(notification: notification)
        bottomConstraint?.update(offset: -keyboardHeight)
        UIView.animate(withDuration: 0, delay: 0, options: UIView.AnimationOptions.curveEaseOut) {
            self.view.layoutIfNeeded()
        } completion: { (completed) in
            self.scrollToLastMessage()
        }
    }
    
    private func scrollToLastMessage() {
        let indexPath = NSIndexPath(item: self.testMessages.count - 1, section: 0) as IndexPath
        self.collectionView?.scrollToItem(at: indexPath, at: .bottom, animated: true)
    }

    @objc private func keyboardWillHide(notification: NSNotification) {
        view.endEditing(true)
        bottomConstraint?.update(offset: 0)
    }
    
    @objc private func pressedSendBtn() {
        if let localMessage = inputChatView.textView.text, !localMessage.isEmpty {
            let newLocalMsg = ChatMessage(messageParse: nil, isSenderInfluencer: isUserInfluencer, localMsg: localMessage)
            testMessages.append(newLocalMsg)
            //TODO: we just need to insert this at the bottom instead of reloading
            collectionView.reloadData()
            scrollToLastMessage()
            inputChatView.textView.text = ""
            let fanID = fan?.objectId ?? ""
            let influencerID = influencer?.objectId ?? ""
            //TODO: this isn't entirely accurate as some of the influencer's messages might be a DM. We need to check if this room is a broadcast channel.
            let messageType = influencer?.objectId == nil ? "Broadcast" : "DM"
            dataStore.sendMessage(fanId: fanID,
                                  influencerID: influencerID,
                                  isUserInfluencer: self.isUserInfluencer,
                                  messageText: localMessage,
                                  messageType: messageType) { messageParse in
                self.testMessages.last?.messageParse = messageParse
                print("succesfully ran sendMessage")
            }
        }
    }
}

extension ChatViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    //TODO: once data store function is hooked up, replace testMessages with messages
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return testMessages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let message = testMessages[indexPath.row]
        let cell = collectionView.dequeueReusableCell(for: indexPath,
                                                         cellType: ChatTextCollectionCell.self)
        let messageText = message.messageParse?.message ?? (message.localMsg ?? "")
        cell.set(profileImage: UIImage(named: "explore"),
                 message: messageText,
                 time: "9:35 PM")
        let estimatedFrame = getMsgFrame(message: messageText)
        let padding: CGFloat = 20
        let horizontalPadding: CGFloat = 16
        let startingInternalPadding: CGFloat = 8
        let profileImgOffset: CGFloat = cell.profileImageView.frame.width + 15
        if message.isSenderInfluencer {
            //incoming message UI
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
        } else {
            //outgoing message UI
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
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let message = testMessages[indexPath.row]
        let messageText = message.messageParse?.message ?? (message.localMsg ?? "")
        let estimatedFrame = getMsgFrame(message: messageText)
        let padding: CGFloat = 20
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
}
