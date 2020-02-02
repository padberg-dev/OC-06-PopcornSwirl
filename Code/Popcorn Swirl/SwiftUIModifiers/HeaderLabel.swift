//
//  HeaderLabel.swift
//  Popcorn Swirl
//
//  Created by Rafal Padberg on 03.12.19.
//  Copyright © 2019 Rafal Padberg. All rights reserved.
//

import SwiftUI

enum HeaderLabelType {
    case h1, h2, h3, h4
}

struct HeaderLabel: ViewModifier {
    var type: HeaderLabelType
    
    func body(content: Content) -> some View {
        content
            .font(getFont())
            .foregroundColor(.sixth)
    }
    
    private func getFont() -> Font {
        switch type {
        case .h1:
            return Font.system(size: 32, weight: .heavy)
        case .h2:
            return Font.system(size: 26, weight: .heavy)
        case .h3:
            return Font.system(size: 22, weight: .heavy)
        case .h4:
            return Font.system(size: 18, weight: .heavy)
        }
    }
}
