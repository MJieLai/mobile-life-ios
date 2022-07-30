//
//  UIViewController+Extension.swift
//  MobileLifeAssessment
//
//  Created by MJ on 30/07/2022.
//

import UIKit

extension UIViewController {
    func showLoader(view: UIView, isIgnoreInteraction: Bool) -> UIActivityIndicatorView {
        let spinner = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 70, height:70))
        spinner.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        spinner.layer.cornerRadius = 3.0
        spinner.clipsToBounds = true
        spinner.hidesWhenStopped = true
        spinner.style = .white
        spinner.center = view.center
        
        view.addSubview(spinner)
        
        spinner.startAnimating()
        
        if isIgnoreInteraction {
            UIApplication.shared.beginIgnoringInteractionEvents()
        }

        return spinner
    }
}

extension UIActivityIndicatorView {
    func dismissLoader() {
        self.stopAnimating()
        UIApplication.shared.endIgnoringInteractionEvents()
    }
 }

