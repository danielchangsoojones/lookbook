//
//  ImageExtension.swift
//  lookbook
//
//  Created by Dan Kwun on 2/9/22.
//

import Foundation
import UIKit
import Parse

extension UIImage {
    func convertToFile() -> PFFileObject? {
        if let imageData = self.jpeg(.lowest) {
            let file = PFFileObject(name:"image.jpeg", data: imageData)
            return file
        }
        
        return nil
    }
    
    func jpeg(_ quality: JPEGQuality) -> Data? {
        return self.jpegData(compressionQuality: quality.rawValue)
    }
    
    enum JPEGQuality: CGFloat {
        case lowest  = 0
        case low     = 0.25
        case medium  = 0.5
        case high    = 0.75
        case highest = 1
    }
}
