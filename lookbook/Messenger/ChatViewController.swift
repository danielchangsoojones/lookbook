//
//  MessengerViewController.swift
//  lookbook
//
//  Created by Daniel Jones on 2/8/22.
//

import UIKit

class ChatViewController: UIViewController {
    private var messages: [String] = ["hey this is danielssdfb sdfbsdfhsf sdjkfn sdkfnsja kfaj fdkls dnfjkdsf jdfjkf sjkfsnfj", "hey this is tyler"]
    private var influencer: InfluencerParse!
    private var collectionView: UICollectionView!
    private let backgroundImgViewTint: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        return view
    }()
    private let backgroundImgView: UIImageView = {
        let img = UIImage(named: "kaiti_bc")
        let imgView = UIImageView(image: img)
        imgView.contentMode = .scaleAspectFill
        return imgView
    }()
    
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
        setBackgroundImgTint()
        setupCollectionView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.reloadData()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
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
    
    private func setBackgroundImg() {
        self.view.addSubview(backgroundImgView)
        backgroundImgView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setBackgroundImgTint() {
        self.view.addSubview(backgroundImgViewTint)
        backgroundImgViewTint.snp.makeConstraints { make in make.edges.equalTo(backgroundImgView)
        }
    }
}

extension ChatViewController: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let message = messages[indexPath.row]
        let cell = collectionView.dequeueReusableCell(for: indexPath,
                                                         cellType: ChatTextCollectionCell.self)
        cell.messageTextView.text = message
        let estimatedFrame = getMsgFrame(message: message)
        let padding: CGFloat = 20
        let horizontalPadding: CGFloat = 16
        let startingInternalPadding: CGFloat = 8
        let profileImgOffset: CGFloat = cell.profileImageView.frame.width + 15
        cell.messageTextView.frame = CGRect(x: startingInternalPadding + profileImgOffset,
                                            y: 0,
                                            width: estimatedFrame.width + horizontalPadding,
                                            height: estimatedFrame.height + padding)
        cell.bubbleView.frame = CGRect(x: profileImgOffset,
                                       y: 0,
                                       width: estimatedFrame.width + horizontalPadding + startingInternalPadding,
                                       height: estimatedFrame.height + padding)
        cell.profileImageView.image = UIImage(named: "explore")
        cell.timeLabel.text = "9:35 PM"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let message = messages[indexPath.row]
        let estimatedFrame = getMsgFrame(message: message)
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
    
    //use this function when we need to show subscription screen
    private func showSubscriptionModalVC(influencer: InfluencerParse) {
        let subscriptionModalVC = SubscriptionModalViewController(influencer: influencer)
        subscriptionModalVC.modalPresentationStyle = .popover
        present(subscriptionModalVC, animated: true)
    }
}
