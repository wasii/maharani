//
//  UIApplication+Extension.swift
//  TemployMe
//
//  Created by A2 MacBook Pro 2012 on 04/12/21.
//

import UIKit

extension UIApplication {
    var keywindow: UIWindow? {
        let scene = UIApplication.shared.connectedScenes.first as? UIWindowScene
        return scene?.windows.filter({ $0.isKeyWindow }).first
    }
    
    func setRoot(vc: UIViewController) {
        keywindow?.rootViewController = vc
    }
}

