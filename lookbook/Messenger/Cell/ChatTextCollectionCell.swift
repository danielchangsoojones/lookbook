//
//  ChatTextCollectionCell.swift
//  lookbook
//
//  Created by Daniel Jones on 2/8/22.
//

import UIKit
import Reusable

class ChatTextCollectionCell: UICollectionViewCell, Reusable {
    let messageTextView: UITextView = {
        let textView = UITextView()
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.backgroundColor = .clear
        return textView
    }()
    
    let bubbleView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 15
        view.layer.masksToBounds = true
        return view
    }()
    
    let profileImageView: UIImageView = {
        let diameter: CGFloat = 33
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: diameter, height: diameter))
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = .green
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = imageView.frame.width / 2
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.borderWidth = 3
        return imageView
    }()
    
    let timeLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 11, weight: .light)
        return label
    }()
    
    
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
        timeLabel.snp.makeConstraints { make in
            make.bottom.equalTo(bubbleView)
            make.leading.equalTo(bubbleView.snp.trailing).offset(3)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
