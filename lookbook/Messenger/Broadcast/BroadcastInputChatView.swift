//
//  BroadcastInputChatView.swift
//  lookbook
//
//  Created by Dan Kwun on 2/13/22.
//

import UIKit

class BroadcastInputChatView: InputChatView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .red
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
