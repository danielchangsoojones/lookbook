//
//  AccountTableViewCell.swift
//  lookbook
//
//  Created by Dan Kwun on 2/8/22.
//

import UIKit
import Reusable

class AccountTableViewCell: UITableViewCell, Reusable {
    private var titleLabel: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .white
        setUpTitleLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    private func setUpTitleLabel() {
        titleLabel = UILabel()
        titleLabel.text = "Log out"
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview()
            make.top.bottom.equalToSuperview().inset(5)
        }
    }
}
