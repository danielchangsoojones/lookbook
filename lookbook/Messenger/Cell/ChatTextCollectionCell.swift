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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
                self.backgroundColor = .red
        contentView.addSubview(bubbleView)
        contentView.addSubview(messageTextView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
