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
        textView.text = "Sample Message"
        return textView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setMessageTextView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setMessageTextView() {
        contentView.addSubview(messageTextView)
        messageTextView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
