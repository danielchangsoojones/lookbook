//
//  StringExtension.swift
//  lookbook
//
//  Created by Dan Kwun on 2/7/22.
//

import UIKit

extension String {
    public var length: Int {
        return self.count
    }
    
    public var isEmail: Bool {
        let dataDetector = try? NSDataDetector(types: NSTextCheckingResult.CheckingType.link.rawValue)
        let firstMatch = dataDetector?.firstMatch(in: self, options: NSRegularExpression.MatchingOptions.reportCompletion, range: NSRange(location: 0, length: length))
        return (firstMatch?.range.location != NSNotFound && firstMatch?.url?.scheme == "mailto")
    }
    
    public var isBlank: Bool {
        let trimmed = trimmingCharacters(in: .whitespacesAndNewlines)
        return trimmed.isEmpty
    }
    
    func removeWhitespaces() -> String {
        return components(separatedBy: .whitespaces).joined()
    }
    
    var numbersOnly: String {
        let numbersOnly = CharacterSet.alphanumerics.inverted
        let numberOnlyStr  = self.components(separatedBy: numbersOnly).joined(separator: "")
        return numberOnlyStr
    }
    
    var isPhoneNumber: Bool {
        let phoneNumber = self.numbersOnly
        
        //To make sure that any Doubles don't use a phone number with .0 (i.e. 3176905323.0)
        if (phoneNumber.count == 10 || phoneNumber.count == 11) {
            return true
        }
        
        return false
    }
}
