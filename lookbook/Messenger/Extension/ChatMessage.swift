//
//  ChatMessage.swift
//  lookbook
//
//  Created by Dan Kwun on 2/12/22.
//

import UIKit

class ChatMessage {
    var isSenderInfluencer: Bool
    var messageParse: MessageParse?
    var localMsg: String?
    
    init(messageParse: MessageParse?, isSenderInfluencer: Bool, localMsg: String?) {
        self.messageParse = messageParse
        self.isSenderInfluencer = isSenderInfluencer
        self.localMsg = localMsg
    }
}
