//
//  SubscriptionModalView.swift
//  lookbook
//
//  Created by Dan Kwun on 2/8/22.
//

import UIKit

class SubscriptionModalView: UIView {
    var exitButton: UIButton!
    private var mainLabel: UILabel!
    private var titleLabel: UILabel!
    private var subtitleLabel: UILabel!
    private var subscriptionInfoBox: UIView!
    var subscribeButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        setUpCloseButton()
        setUpMainLabel()
        setUpTitleLabel()
        setUpSubtitleLabel()
        setUpSubscriptionInfoBox()
        setUpSubscribeButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpCloseButton() {
        if let image = UIImage(named: "x")?.withRenderingMode(.alwaysTemplate) {
            exitButton = UIButton()
            exitButton.tintColor = .black
            addSubview(exitButton)
            exitButton.setImage(image, for: .normal)
            exitButton.imageView?.contentMode = .scaleAspectFit
            exitButton.snp.makeConstraints { make in
                make.top.equalToSuperview().inset(15)
                make.leading.equalToSuperview().inset(10)
            }
        }
    }
    
    private func setUpMainLabel() {
        mainLabel = UILabel()
        mainLabel.text = "Kaiti's Membership"
        mainLabel.font = .systemFont(ofSize: 20, weight: .bold)
        addSubview(mainLabel)
        mainLabel.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalTo(exitButton.snp.centerY)
        }
    }
    
    private func setUpTitleLabel() {
        titleLabel = UILabel()
        titleLabel.text = "Subscribe to receive & send messages!"
        titleLabel.numberOfLines = 0
        titleLabel.font = .systemFont(ofSize: 23, weight: .bold)
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(20)
            make.top.equalTo(mainLabel.snp.bottom).offset(20)
        }
    }
    
    private func setUpSubtitleLabel() {
        subtitleLabel = UILabel()
        subtitleLabel.text = "• You can cancel subscription anytime! Purchase is non-refundable"
        subtitleLabel.font = .systemFont(ofSize: 13, weight: .regular)
        subtitleLabel.numberOfLines = 0
        addSubview(subtitleLabel)
        subtitleLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(35)
            make.top.equalTo(titleLabel.snp.bottom).offset(15)
        }
    }
    
    private func setUpSubscriptionInfoBox() {
        subscriptionInfoBox = UIView()
        subscriptionInfoBox.layer.cornerRadius = 19
        subscriptionInfoBox.layer.borderWidth = 1
        subscriptionInfoBox.backgroundColor = UIColor(red: 249/256, green: 249/256, blue: 249/256, alpha: 1)
        subscriptionInfoBox.layer.borderColor = UIColor(red: 235/256, green: 82/256, blue: 84/256, alpha: 1).cgColor
        addSubview(subscriptionInfoBox)
        subscriptionInfoBox.snp.makeConstraints { make in
            make.leading.trailing.equalTo(titleLabel)
            make.top.equalTo(subtitleLabel.snp.bottom).offset(15)
        }
        
        let infoTitleLabel = UILabel()
        infoTitleLabel.text = "$10 per month"
        infoTitleLabel.textColor = UIColor(red: 235/256, green: 82/256, blue: 84/256, alpha: 1.0)
        infoTitleLabel.font = .systemFont(ofSize: 22, weight: .bold)
        subscriptionInfoBox.addSubview(infoTitleLabel)
        infoTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(25)
            make.leading.equalToSuperview().inset(20)
        }
        let infoSubtitleLabel = UILabel()
        infoSubtitleLabel.text = "• Private DMs with the one and only Kaiti Yoo!\n• Get photos and videos that Kaiti would send to her friends. Why? Because you’re now Kaiti’s friend! : ) "
        infoSubtitleLabel.numberOfLines = 0
        infoSubtitleLabel.font = .systemFont(ofSize: 13, weight: .regular)
        subscriptionInfoBox.addSubview(infoSubtitleLabel)
        infoSubtitleLabel.snp.makeConstraints { make in
            make.top.equalTo(infoTitleLabel.snp.bottom).offset(12)
            make.leading.trailing.equalToSuperview().inset(30)
            make.bottom.equalTo(subscriptionInfoBox.snp.bottom).inset(25)
        }
    }
    
    private func setUpSubscribeButton() {
        subscribeButton = UIButton()
        subscribeButton.backgroundColor = .black
        subscribeButton.setTitle("Subscribe", for: .normal)
        subscribeButton.setTitleColor(.white, for: .normal)
        subscribeButton.titleLabel?.font = .systemFont(ofSize: 20, weight: .medium)
        subscribeButton.layer.cornerRadius = 23
        subscribeButton.contentEdgeInsets = UIEdgeInsets(top: 12, left: 0, bottom: 12, right: 0)
        addSubview(subscribeButton)
        subscribeButton.snp.makeConstraints { make in
            make.leading.trailing.equalTo(titleLabel)
            make.top.equalTo(subscriptionInfoBox.snp.bottom).offset(20)
        }
    }
}
