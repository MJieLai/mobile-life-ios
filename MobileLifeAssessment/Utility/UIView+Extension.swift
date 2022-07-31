//
//  UIView+Extension.swift
//  MobileLifeAssessment
//
//  Created by MJ on 31/07/2022.
//

import UIKit
import Toast_Swift

extension UIView {
    open func showToastOnTopStyle(_ message:String, completion: ((_ didTap: Bool) -> Void)? = nil) {
        self.hideToastActivity()
        var style:ToastStyle = ToastStyle.init()
        style.messageFont = UIFont.systemFont(ofSize: 15)
        self.makeToast(message, duration: 2, position: .top, title: nil, image: nil, style: style) { (ended) in
            guard let completionHandler = completion else { return }
            completionHandler(ended)
        }
    }
}

