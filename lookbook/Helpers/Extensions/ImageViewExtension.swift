//
//  ImageViewExtension.swift
//  lookbook
//
//  Created by Dan Kwun on 2/8/22.
//

import Foundation
import Parse

extension UIImageView {
    func loadFromFile(_ file: AnyObject?) {
        if let parseFile = file as? PFFileObject {
            retrieveParseData(parseFile)
        }
    }
    
    private func retrieveParseData(_ file: PFFileObject) {
        file.getDataInBackground(block: { (data, error) in
            if let data = data {
                self.loadImageFromData(data)
            } else if (error != nil) {
                BannerAlert.show(with: error)
            } else {
                print("error")
            }
        })
    }
    
    private func loadImageFromData(_ data: Data) {
        self.image = UIImage(data: data)
    }
    
    func addTap(target: Any?, action: Selector) {
        self.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: target, action: action)
        self.addGestureRecognizer(tap)
    }
}
