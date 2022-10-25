//
//  Double+Extension.swift
//  Laundry Web
//
//  Created by A2 MacBook Pro 2012 on 23/11/21.
//

import Foundation

extension Double {
    var removeTrailingZeros: String {
        return truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
}
