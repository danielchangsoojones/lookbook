//
//  MasterChatRoomView.swift
//  lookbook
//
//  Created by Dan Kwun on 2/8/22.
//

import UIKit

class MasterChatRoomView: UIView {
    private var titleLabel: UILabel!
    var tableView: UITableView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setUpTitleLabel()
        setUpTableView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpTitleLabel() {
        titleLabel = UILabel()
        titleLabel.text = "Messages"
        titleLabel.font = .systemFont(ofSize: 36, weight: .regular)
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.equalTo(self.snp.topMargin).inset(30)
        }
    }
    
    private func setUpTableView() {
        tableView = UITableView()
        addSubview(tableView)
        tableView.snp.makeConstraints { (make) in
            make.leading.trailing.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp.bottom).offset(15)
            make.bottom.equalToSuperview()
        }
    }

}
