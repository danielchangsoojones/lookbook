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
    private var rightButton: UIButton!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .white
        setUpTitleLabel()
        setUpRightArrow()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    private func setUpTitleLabel() {
        titleLabel = UILabel()
//        titleLabel.text = "Log out"
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview()
            make.top.bottom.equalToSuperview().inset(10)
        }
    }
    
    func set(rowLabel: String) {
        titleLabel.text = rowLabel
    }
    
    private func setUpRightArrow() {
        if let image = UIImage(named: "right_chevron")?.withRenderingMode(.alwaysTemplate) {
            rightButton = UIButton()
            rightButton.tintColor = .black
            contentView.addSubview(rightButton)
            rightButton.setImage(image, for: .normal)
            rightButton.imageView?.contentMode = .scaleAspectFit
            rightButton.snp.makeConstraints { make in
                make.centerY.equalTo(titleLabel)
                make.trailing.equalToSuperview().inset(10)
            }
        }
    }
}
