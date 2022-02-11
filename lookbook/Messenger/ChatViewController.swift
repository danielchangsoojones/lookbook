//
//  MessengerViewController.swift
//  lookbook
//
//  Created by Daniel Jones on 2/8/22.
//

import UIKit

class ChatViewController: UIViewController {
    struct TestMessage {
        let message: String
        let isSenderCeleb: Bool
    }
    private var collectionView: UICollectionView!
    private let backgroundImgView = UIImageView()
    private let backgroundGradient = CAGradientLayer()
    private let inputChatView = InputChatView()
    private var influencer: InfluencerParse!
    private var testMessages: [TestMessage]!
    private var messages: [MessageParse] = []
    private var sendMessageButton: UIButton!
    private var dataStore = MessengerDataStore()
    private func populateMessageArray() {
        testMessages = [
            TestMessage(message: "hey this is danielssdfb sdfbsdfhsf sdjkfn sdkfnsja kfaj fdkls dnfjkdsf jdfjkf sjkfsnfj", isSenderCeleb: true),
            TestMessage(message: "hey this is tyler", isSenderCeleb: true),
            TestMessage(message: "wowowow", isSenderCeleb:true),
            TestMessage(message: "hey this is danielssdfb sdfbsdfhsf sdjkfn sdkfnsja kfaj fdkls dnfjkdsf jdfjkf sjkfsnfj", isSenderCeleb: false),
            TestMessage(message: "hey this is tyler", isSenderCeleb: false),
            TestMessage(message: "wowowow", isSenderCeleb: false)
        ]
    }
    
    init(influencer: InfluencerParse) {
        self.influencer = influencer
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        super.loadView()
        setBackgroundImg()
        setupCollectionView()
        setInputView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tabBarController?.tabBar.isHidden = true
        collectionView.reloadData()
        populateMessageArray() //TODO: DELETE & LOAD FROM MESSAGES
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
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        backgroundGradient.frame = backgroundImgView.bounds
    }
    
    private func loadMessages() {
        dataStore.loadMessages(influencerObjectId: influencer.objectId ?? "", completion: { messages in
            self.messages = messages
            self.collectionView.reloadData()
        })
    }
    
    private func setBackgroundImg() {
        view.backgroundColor = .white
        if let image = influencer.chatBackgroundPhoto {
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
    }
    
    private func setInputView() {
        sendMessageButton = inputChatView.sendButton
        sendMessageButton.addTarget(self, action: #selector(pressedSendBtn), for: .touchUpInside)
        view.addSubview(inputChatView)
        inputChatView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    @objc private func pressedSendBtn() {
        //TODO: Call datastore function + send message
        print("send button")
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
        cell.set(profileImage: UIImage(named: "explore"),
                 message: message.message,
                 time: "9:35 PM")
        let estimatedFrame = getMsgFrame(message: message.message)
        let padding: CGFloat = 20
        let horizontalPadding: CGFloat = 16
        let startingInternalPadding: CGFloat = 8
        let profileImgOffset: CGFloat = cell.profileImageView.frame.width + 15
        if message.isSenderCeleb {
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
        let estimatedFrame = getMsgFrame(message: message.message)
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
