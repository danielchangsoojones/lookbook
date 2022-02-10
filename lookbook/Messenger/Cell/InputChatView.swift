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
        textView.maxHeight = 100
        return textView
    }()
    
//    let sendButton: UIButton {
//        let btn = UIButton()
//        btn.setImage(<#T##image: UIImage?##UIImage?#>, for: <#T##UIControl.State#>)
//    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(textView)
        textView.snp.makeConstraints { make in
            make.leading.equalToSuperview().offset(10)
            
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
