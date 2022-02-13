//
//  ChatTextCollectionCell.swift
//  lookbook
//
//  Created by Daniel Jones on 2/8/22.
//

import UIKit
import Reusable

class ChatTextCollectionCell: UICollectionViewCell, Reusable {
    let profileImageView: UIImageView = {
        let diameter: CGFloat = 47
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: diameter, height: diameter))
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .green
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = imageView.frame.width / 2
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.borderWidth = 3
        return imageView
    }()
    let bubbleView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 15
        view.layer.masksToBounds = true
        return view
    }()
    let messageTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.backgroundColor = .clear
        textView.isEditable = false
        return textView
    }()
    let timeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 11, weight: .light)
        return label
    }()
     
    func set(profileImage: AnyObject?, message: String, time: String) {
        profileImageView.loadFromFile(profileImage)
        messageTextView.text = message
        timeLabel.text = time
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(bubbleView)
        contentView.addSubview(messageTextView)
        contentView.addSubview(profileImageView)
        contentView.addSubview(timeLabel)
        profileImageView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.height.width.equalTo(profileImageView.frame.width)
            make.bottom.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
