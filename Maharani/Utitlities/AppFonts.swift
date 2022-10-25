//
//  AppFonts.swift
//  TemployMe
//
//  Created by A2 MacBook Pro 2012 on 04/12/21.
//

import Foundation
import UIKit

private let familyName = "Roboto"

enum AppFont: String {
    case regular = "Regular"
    case medium = "Medium"
    case bold = "Bold"

    func size(_ size: CGFloat) -> UIFont {
        if let font = UIFont(name: fullFontName, size: size + 1.0) {
            return font
        }
        fatalError("Font '\(fullFontName)' does not exist.")
    }
    fileprivate var fullFontName: String {
        return rawValue.isEmpty ? familyName : familyName + "-" + rawValue
    }
}
