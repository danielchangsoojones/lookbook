//
//  SpinningButton.swift
//  lookbook
//
//  Created by Daniel Jones on 2/23/22.
//

import UIKit

class SpinningButton: UIButton {
    private let spinner = UIActivityIndicatorView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setSpinner()
        setTitle("", for: .disabled)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func startSpinning() {
        spinner.startAnimating()
        isEnabled = false
    }
    
    func stopSpinning() {
        spinner.stopAnimating()
        isEnabled = true
    }
    
    private func setSpinner() {
        spinner.color = .white
        addSubview(spinner)
        spinner.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.equalToSuperview().multipliedBy(0.8)
            make.width.equalTo(self.snp.height).multipliedBy(0.8)
        }
    }
}
