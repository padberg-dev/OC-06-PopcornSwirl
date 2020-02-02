//
//  PopcornLoader.swift
//  Popcorn Swirl
//
//  Created by Rafal Padberg on 12.11.19.
//  Copyright © 2019 Rafal Padberg. All rights reserved.
//

import SwiftUI

struct PopcornLoader_Previews: PreviewProvider {
    static var previews: some View {
        PopcornLoader(number: .constant(3))
    }
}

struct PopcornLoader: View {
    @State private var flag = false
    @Binding var number: Double
    
    var body: some View {
        GeometryReader { proxy in
            ZStack(alignment: .topLeading) {
                
                // Draw the Infinity Shape
                Spiral()
                    .stroke(Color.clear)
                    .aspectRatio(contentMode: .fit)
                    .frame(width: proxy.size.width, height: proxy.size.width)
                
                // BIG POPCORN
                Image("PopCorn1").resizable().foregroundColor(Color.red)
                    .frame(width: proxy.size.width / 2, height: proxy.size.width / 2).offset(x: -proxy.size.width / 4, y: -proxy.size.width / 4)
                    .modifier(FollowEffect(pct: self.flag ? 1 : 0, path: Spiral.createPath(in: CGRect(x: 0, y: 0, width: proxy.size.width, height: proxy.size.width)), rotate: true, offset: 0))
                    .opacity(self.number - 0)
                
                
                Image("PopCorn1").resizable().foregroundColor(Color.red)
                    .frame(width: proxy.size.width / 2, height: proxy.size.width / 2).offset(x: -proxy.size.width / 4, y: -proxy.size.width / 4)
                    .modifier(FollowEffect(pct: self.flag ? 1 : 0, path: Spiral.createPath(in: CGRect(x: 0, y: 0, width: proxy.size.width, height: proxy.size.width)), rotate: true, offset: 1/3))
                    .opacity(max(0, self.number - 1))
                
                Image("PopCorn1").resizable().foregroundColor(Color.red)
                    .frame(width: proxy.size.width / 2, height: proxy.size.width / 2).offset(x: -proxy.size.width / 4, y: -proxy.size.width / 4)
                    .modifier(FollowEffect(pct: self.flag ? 1 : 0, path: Spiral.createPath(in: CGRect(x: 0, y: 0, width: proxy.size.width, height: proxy.size.width)), rotate: true, offset: 2/3))
                    .opacity(max(0, self.number - 2))
                
            }
            .onAppear {
                withAnimation(Animation.linear(duration: 8.0).repeatForever(autoreverses: false)) {
                    self.flag.toggle()
                }
            }
        }
    }
}

struct FollowEffect: GeometryEffect {
    var pct: CGFloat = 0
    let path: Path
    var rotate = true
    let offset: CGFloat
    
    var animatableData: CGFloat {
        get { return pct }
        set { pct = newValue }
    }
    
    func effectValue(size: CGSize) -> ProjectionTransform {
        
        let prcnt = (pct + offset).truncatingRemainder(dividingBy: 1)
        
        if !rotate {
            let pt = percentPoint(prcnt)
            
            return ProjectionTransform(CGAffineTransform(translationX: pt.x, y: pt.y))
        } else {
            // Calculate rotation angle, by calculating an imaginary line between two points
            // in the path: the current position (1) and a point very close behind in the path (2).
            
            let pt1 = percentPoint(prcnt)
            let pt2 = percentPoint(prcnt - 0.01)
            
            let a = pt2.x - pt1.x
            let b = pt2.y - pt1.y
            
//                        let angle = a < 0 ? atan(Double(b / a)) : atan(Double(b / a)) - Double.pi
            
            let angle = -prcnt * 2 * .pi
            
            let transform = CGAffineTransform(translationX: pt1.x, y: pt1.y).rotated(by: CGFloat(angle))
            
            return ProjectionTransform(transform)
        }
    }
    
    func percentPoint(_ percent: CGFloat) -> CGPoint {
        
        let pct = percent > 1 ? 0 : (percent < 0 ? 1 : percent)
        
        let f = pct > 0.999 ? CGFloat(1-0.001) : pct
        let t = pct > 0.999 ? CGFloat(1) : pct + 0.001
        let tp = path.trimmedPath(from: f, to: t)
        
        return CGPoint(x: tp.boundingRect.midX, y: tp.boundingRect.midY)
    }
}

struct InfinityShape: Shape {
    func path(in rect: CGRect) -> Path {
        return InfinityShape.createInfinityPath(in: rect)
    }
    
    static func createInfinityPath(in rect: CGRect) -> Path {
        let height = rect.size.height
        let width = rect.size.width
        let heightFactor = height/4
        let widthFactor = width/4
        
        var path = Path()
        
        path.move(to: CGPoint(x:widthFactor, y: heightFactor * 3))
        path.addCurve(to: CGPoint(x:widthFactor, y: heightFactor), control1: CGPoint(x:0, y: heightFactor * 3), control2: CGPoint(x:0, y: heightFactor))
        
        path.move(to: CGPoint(x:widthFactor, y: heightFactor))
        path.addCurve(to: CGPoint(x:widthFactor * 3, y: heightFactor * 3), control1: CGPoint(x:widthFactor * 2, y: heightFactor), control2: CGPoint(x:widthFactor * 2, y: heightFactor * 3))
        
        path.move(to: CGPoint(x:widthFactor * 3, y: heightFactor * 3))
        path.addCurve(to: CGPoint(x:widthFactor * 3, y: heightFactor), control1: CGPoint(x:widthFactor * 4 + 5, y: heightFactor * 3), control2: CGPoint(x:widthFactor * 4 + 5, y: heightFactor))
        
        path.move(to: CGPoint(x:widthFactor * 3, y: heightFactor))
        path.addCurve(to: CGPoint(x:widthFactor, y: heightFactor * 3), control1: CGPoint(x:widthFactor * 2, y: heightFactor), control2: CGPoint(x:widthFactor * 2, y: heightFactor * 3))
        
        return path
    }
}


struct Spiral: Shape {
    
    func path(in rect: CGRect) -> Path {
        return Spiral.createPath(in: rect)
    }

    static func createPath(in rect: CGRect) -> Path {
        return Path { path in
            let start = CGPoint(x: 0, y: 0.5)
            path.move(to: start)
            path.addCurve(to: CGPoint(x: 0.328, y: 0.201), control1: CGPoint(x: 0, y: 0.286), control2: CGPoint(x: 0.2, y: 0.183))
            path.addCurve(to: CGPoint(x: 0.519, y: 0.295), control1: CGPoint(x: 0.395
                , y: 0.208), control2: CGPoint(x: 0.467, y: 0.236 ))
            path.addCurve(to: CGPoint(x: 0.534, y: 0.443), control1: CGPoint(x: 0.563, y: 0.344), control2: CGPoint(x: 0.560, y: 0.403))
            path.addCurve(to: CGPoint(x: 0.430, y: 0.500), control1: CGPoint(x: 0.504, y: 0.488), control2: CGPoint(x: 0.472, y: 0.500))
            path.addCurve(to: CGPoint(x: 0.314, y: 0.420), control1: CGPoint(x: 0.378, y: 0.500), control2: CGPoint(x: 0.328, y: 0.466))
            
            path.addCurve(to: CGPoint(x: 0.328, y: 0.201), control1: CGPoint(x: 0.300, y: 0.376), control2: CGPoint(x: 0.285, y: 0.289))
            path.addCurve(to: CGPoint(x: 0.749, y: 0.066), control1: CGPoint(x: 0.411, y: 0.016), control2: CGPoint(x: 0.635, y: -0.007))
            path.addCurve(to: CGPoint(x: 0.845, y: 0.500), control1: CGPoint(x: 0.887, y: 0.152), control2: CGPoint(x: 0.958, y: 0.327))
            path.addCurve(to: CGPoint(x: 0.675, y: 0.617), control1: CGPoint(x: 0.792, y: 0.573), control2: CGPoint(x: 0.721, y: 0.608))
            path.addCurve(to: CGPoint(x: 0.536, y: 0.563), control1: CGPoint(x: 0.619, y: 0.632), control2: CGPoint(x: 0.563, y: 0.611))
            path.addCurve(to: CGPoint(x: 0.535, y: 0.442), control1: CGPoint(x: 0.515, y: 0.527), control2: CGPoint(x: 0.513, y: 0.473))
            path.addCurve(to: CGPoint(x: 0.668, y: 0.381), control1: CGPoint(x: 0.557, y: 0.400), control2: CGPoint(x: 0.610, y: 0.366))
            path.addCurve(to: CGPoint(x: 0.845, y: 0.501), control1: CGPoint(x: 0.736, y: 0.393), control2: CGPoint(x: 0.808, y: 0.445))
            path.addCurve(to: CGPoint(x: 0.749, y: 0.934 ), control1: CGPoint(x: 0.955, y: 0.662), control2: CGPoint(x: 0.887, y: 0.854))
            path.addCurve(to: CGPoint(x: 0.328, y: 0.799), control1: CGPoint(x: 0.536, y: 1.040), control2: CGPoint(x: 0.373, y: 0.905))
            path.addCurve(to: CGPoint(x: 0.315, y: 0.580), control1: CGPoint(x: 0.295, y: 0.719), control2: CGPoint(x: 0.291, y: 0.662))
            path.addCurve(to: CGPoint(x: 0.430, y: 0.500), control1: CGPoint(x: 0.334, y: 0.537), control2: CGPoint(x: 0.370, y: 0.500))
            path.addCurve(to: CGPoint(x: 0.535, y: 0.563), control1: CGPoint(x: 0.480, y: 0.500), control2: CGPoint(x: 0.515, y: 0.525))
            path.addCurve(to: CGPoint(x: 0.527, y: 0.697), control1: CGPoint(x: 0.557, y: 0.599), control2: CGPoint(x: 0.563, y: 0.649))
            path.addCurve(to: CGPoint(x: 0.327, y: 0.799), control1: CGPoint(x: 0.463, y: 0.768), control2: CGPoint(x: 0.384, y: 0.795))
            path.addCurve(to: CGPoint(x: 0, y: 0.500), control1: CGPoint(x: 0.197, y: 0.812), control2: CGPoint(x: 0, y: 0.710))

        }
        .applying(CGAffineTransform(scaleX: rect.width, y: rect.height))
    }
}
