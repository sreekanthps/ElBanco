//
//  UINavigationHelper.swift
//  BitBucketList
//
//  Created by Sreekanth on 3/9/21.
//

import Foundation
import UIKit
extension UIView {
    public func removeAllSubviewsAndRemoveFromSuperview() {
        subviews.forEach { (subview) in
            subview.removeFromSuperview()
        }
        removeFromSuperview()
    }

    public func removeAllSubviews() {
        subviews.forEach { (subview) in
            subview.removeFromSuperview()
        }
    }
}
extension UIViewController {
    
    func notifyAlert(_ msg: String, err: String?, completionHandler: ((UIAlertAction) -> Void)?) {
            let alert = UIAlertController(title: msg,
                message: err,
                preferredStyle: .alert)

            let cancelAction = UIAlertAction(title: "OK",
                style: .cancel, handler: completionHandler)

            alert.addAction(cancelAction)

            self.present(alert, animated: true,
                                completion: nil)
        }
}

extension UIWindow {
    func topViewController() -> UIViewController? {
        var top = self.rootViewController
        while true {
            if let presented = top?.presentedViewController {
                top = presented
            } else if let nav = top as? UINavigationController {
                top = nav.visibleViewController
            } else if let tab = top as? UITabBarController {
                top = tab.selectedViewController
            } else {
                break
            }
        }
        return top
    }
}
