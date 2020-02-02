//
//  PopcornShapeView.swift
//  Popcorn Swirl
//
//  Created by Rafal Padberg on 21.11.19.
//  Copyright © 2019 Rafal Padberg. All rights reserved.
//

import SwiftUI

struct PopcornShapeView: View {
    var body: some View {
        PopcornShape()
    }
}

struct PopcornShape: Shape {
    
    func path(in rect: CGRect) -> Path {
        return Path { path in
            return Path { path in
                let start = CGPoint(x: 0.1915, y: 0.2595)
                path.move(to: start)
                path.addCurve(to: CGPoint(x: 0.2115, y: 0.5425), control1: CGPoint(x: 0.163, y: 0.366), control2: CGPoint(x: 0.1709, y: 0.4785))
                path.addCurve(to: CGPoint(x: 0.3965, y: 0.653), control1: CGPoint(x: 0.2519, y: 0.6055), control2: CGPoint(x: 0.2979, y: 0.653))
                path.addCurve(to: CGPoint(x: 0.5329, y: 0.581), control1: CGPoint(x: 0.4405, y: 0.654), control2: CGPoint(x: 0.4985, y: 0.6335))
                path.addCurve(to: CGPoint(x: 0.3715, y: 0.679), control1: CGPoint(x: 0.520, y: 0.618), control2: CGPoint(x: 0.478, y: 0.679))
                path.addCurve(to: CGPoint(x: 0.1395, y: 0.5385), control1: CGPoint(x: 0.2639, y: 0.6765), control2: CGPoint(x: 0.1949, y: 0.641))
                path.addCurve(to: CGPoint(x: 0.082, y: 0.283), control1: CGPoint(x: 0.0839, y: 0.436), control2: CGPoint(x: 0.0785, y: 0.358))
                path.addLine(to: CGPoint(x: 0.0875, y: 0.239))

            }
            .applying(CGAffineTransform(scaleX: rect.width, y: rect.height))
        }
    }
}

struct PopcornShapeView_Previews: PreviewProvider {
    static var previews: some View {
        PopcornShapeView()
    }
}
