//
//  MessengerViewController.swift
//  lookbook
//
//  Created by Daniel Jones on 2/8/22.
//

import UIKit

class ChatViewController: UIViewController {
    private var messages: [String] = ["hey this is danielssdfb sdfbsdfhsf sdjkfn sdkfnsja kfaj fdkls dnfjkdsf jdfjkf sjkfsnfj", "hey this is tyler"]
    private var collectionView: UICollectionView!
    
    override func loadView() {
        super.loadView()
        setupCollectionView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.backgroundColor = .blue
        collectionView.reloadData()
        // Do any additional setup after loading the view.
    }
    
    private func setupCollectionView() {
        let frame = CGRect(x: 0,
                           y: 0,
                           width: self.view.frame.width,
                           height: self.view.frame.height)
        let layout = UICollectionViewFlowLayout()
        collectionView = UICollectionView(frame: frame, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(cellType: ChatTextCollectionCell.self)
        view.addSubview(collectionView)
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
        let profileImgOffset: CGFloat = 48
        cell.messageTextView.frame = CGRect(x: startingInternalPadding + profileImgOffset,
                                            y: 0,
                                            width: estimatedFrame.width + horizontalPadding,
                                            height: estimatedFrame.height + padding)
        cell.bubbleView.frame = CGRect(x: profileImgOffset,
                                       y: 0,
                                       width: estimatedFrame.width + horizontalPadding + startingInternalPadding,
                                       height: estimatedFrame.height + padding)
        cell.timeLabel.text = "9:35 PM"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let message = messages[indexPath.row]
        let estimatedFrame = getMsgFrame(message: message)
        let padding: CGFloat = 20
        return CGSize(width: view.frame.width, height: estimatedFrame.height + padding)
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
}
