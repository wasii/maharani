//
//  String+Extension.swift
//  Laundry Web
//
//  Created by A2 MacBook Pro 2012 on 23/11/21.
//

import Foundation

extension String {
    func removeTrailingZeros() -> String {
        return String(format: "%.0f", self)
    }
}
