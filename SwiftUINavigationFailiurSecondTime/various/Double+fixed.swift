//
//  Double+fixed.swift
//  SwiftUINavigationFailiurSecondTime
//
//  Created by Sven Svensson on 14/07/2021.
//

import Foundation

extension Double {

    func fixed(precision: Int) -> String {
        return String(format: "%.\(precision)f", self)
    }
    
    func fixed(precision: Double) -> String {
        return self.fixed(precision: Int(precision))
    }
}
