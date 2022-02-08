//
//  ViewControllerExtension.swift
//  lookbook
//
//  Created by Dan Kwun on 2/7/22.
//

import UIKit

extension UIViewController {
    open func pushVC(_ vc: UIViewController) {
        navigationController?.pushViewController(vc, animated: true)
    }
    
    public func popVC() {
        _ = navigationController?.popViewController(animated: true)
    }
}
