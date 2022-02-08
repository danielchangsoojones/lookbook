//
//  HomeView.swift
//  lookbook
//
//  Created by Dan Kwun on 2/7/22.
//

import UIKit

class HomeView: UIView {
    private var titleLabel: UILabel!
    private var subTitleLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setUpTitleLabel()
        setUpSubtitleLabel()
        setUpTableView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpTitleLabel() {
        titleLabel = UILabel()
        titleLabel.text = "Discover"
        titleLabel.font = .systemFont(ofSize: 36, weight: .regular)
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.equalTo(self.snp.topMargin).inset(30)
        }
    }
    
    private func setUpSubtitleLabel() {
        subTitleLabel = UILabel()
        subTitleLabel.text = "EVERYONE’S FAVORITE INFLUENCERS"
        subTitleLabel.font = .systemFont(ofSize: 18, weight: .black)
        subTitleLabel.textAlignment = .left
        addSubview(subTitleLabel)
        subTitleLabel.snp.makeConstraints { (make) in
            make.leading.trailing.equalTo(titleLabel)
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
        }
    }
    
    private func setUpTableView() {
        
    }
}
