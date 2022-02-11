//
//  InputChatView.swift
//  lookbook
//
//  Created by Daniel Jones on 2/9/22.
//

import UIKit
import GrowingTextView

class InputChatView: UIView {
    let textView: GrowingTextView = {
        let textView = GrowingTextView()
        textView.maxHeight = 150
        textView.minHeight = 34
        textView.contentInset = UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 0)
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.layer.cornerRadius = 20
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor(red: 0.78, green: 0.78, blue: 0.78, alpha: 1).cgColor
        return textView
    }()
    
    let sendButton: UIButton = {
        let btn = UIButton()
        let img = UIImage(named: "send")
        btn.setImage(img, for: .normal)
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addSubview(sendButton)
        addSubview(textView)
        sendButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(14)
            make.centerY.equalToSuperview()
            make.width.height.equalTo(18)
        }
        textView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            make.trailing.equalTo(sendButton.snp.leading).offset(-8)
            make.top.bottom.equalToSuperview().inset(8)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
