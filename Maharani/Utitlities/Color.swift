//
//  Color.swift
//  TemployMe
//
//  Created by A2 MacBook Pro 2012 on 04/12/21.
//

import UIKit

enum Color: String, CaseIterable {
    case blue = "teal_700"
    case dark = "dark"
    case green = "green"
    case textBackground = "textBackground"
    case pink = "teal_200"
    case redish = "Redish"
    case black = "Black"
   

    func color() -> UIColor {
        guard let color = UIColor(named: rawValue) else {
            fatalError("No such color found")
        }
        return color
    }
}


