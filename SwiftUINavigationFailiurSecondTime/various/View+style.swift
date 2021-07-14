//
//  View+style.swift
//  SwiftUINavigationFailiurSecondTime
//
//  Created by Sven Svensson on 14/07/2021.
//

import Foundation
import SwiftUI


enum CustomViewStyle {
    case title
    case smallTitle
    case label
    case smallLabel
    case text
    case smallText
    case textField
    case collumHeader
    
}

extension View {
    @ViewBuilder func style(_ style: CustomViewStyle) -> some View {
        switch style {
        case .title:
            self.font(.title).foregroundColor(.primary)
        case .smallTitle:
            self.font(.headline).foregroundColor(.primary)
        case .label:
            self.font(.body).foregroundColor(.primary)
        case .smallLabel:
            self.font(.system(size: 14.0, weight: .ultraLight, design: .default)).font(.subheadline).foregroundColor(.secondary)
        case .text:
            self.font(.body).foregroundColor(.secondary)
        case .smallText:
            self.font(.subheadline).foregroundColor(.secondary)
        case .textField:
            self.font(.body).foregroundColor(.secondary)
        case .collumHeader:
            self.font(.caption2).foregroundColor(.secondary)
        
        }
    }
}
