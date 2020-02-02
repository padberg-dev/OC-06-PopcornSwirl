//
//  Loader.swift
//  Popcorn Swirl
//
//  Created by Rafal Padberg on 11.11.19.
//  Copyright © 2019 Rafal Padberg. All rights reserved.
//

import SwiftUI

var headPoint: CGSize = .zero

struct Loader: View {
    @State var position: CGFloat = 0
    let rect: some Shape = Rectangle()
        .size(width: 20, height: 20)
    
    let arrowHead: some Shape = ArrowHead()
        .size(width: 20, height: 20)
    
    func getPathOffset(for position: CGFloat) -> CGSize {
        
        let (point, _) = Spiral().path(in: .init(origin: .zero, size: .init(width: 100, height: 100))).pointAndAngle(at: position)
        return .init(width: point.x, height: point.y)
    }
    
    var body: some View {
        VStack {
            ZStack {
                Spiral()
                    .stroke(Color.black)
                
//                Image(systemName: "airplane")
//                    .offset(headPoint)
//
                OnPath(shape: rect, pathShape: Spiral(), offset: position)
                    .foregroundColor(Color.init(hue: 0, saturation: 1, brightness: 1))
//                OnPath(shape: rect, pathShape: Spiral(), offset: position + 1 / 6)
//                    .foregroundColor(Color.init(hue: 1/6, saturation: 0.5, brightness: 0.5))
//                OnPath(shape: rect, pathShape: Spiral(), offset: (position + 2 / 6))
//                    .foregroundColor(Color.init(hue: 2/6, saturation: 1, brightness: 1))
//                OnPath(shape: rect, pathShape: Spiral(), offset: (position + 3 / 6))
//                    .foregroundColor(Color.init(hue: 3/6, saturation: 1, brightness: 1))
//                OnPath(shape: rect, pathShape: Spiral(), offset: (position + 4 / 6))
//                    .foregroundColor(Color.init(hue: 4/6, saturation: 1, brightness: 1))
//                OnPath(shape: rect, pathShape: Spiral(), offset: (position + 5 / 6))
//                    .foregroundColor(Color.init(hue: 5/6, saturation: 1, brightness: 1))
                
//                OnPath(shape: rect, pathShape: Spiral(), offset: (position + 1/6))
//                    .foregroundColor(.black)
//                OnPath(shape: rect, pathShape: Spiral(), offset: position + 3 / 6)
//                .foregroundColor(.red)
//                OnPath(shape: rect, pathShape: Spiral(), offset: position + 5 / 6)
//                .foregroundColor(.blue)
            }
            .aspectRatio(1, contentMode: .fit)
            .padding(20)
        }
        .onAppear {
            withAnimation(Animation.linear(duration: 26).repeatForever(autoreverses: false)) {
                self.position = 1
            }
        }
    }
}

struct ArrowHead: Shape {
    func path(in rect: CGRect) -> Path {
        return Path { p in
            p.move(to: CGPoint(x: rect.minX, y: rect.maxY))
            p.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
            p.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        }.strokedPath(trailStyle)
    }
}

let trailStyle = StrokeStyle(lineWidth: 3)

extension Path {
    func point(at position: CGFloat) -> CGPoint {
        let position = position.truncatingRemainder(dividingBy: 1)
        assert(position >= 0 && position <= 1)
        guard position > 0 else { return cgPath.currentPoint }
        return trimmedPath(from: 0, to: position).cgPath.currentPoint
    }
    
    func pointAndAngle(at position: CGFloat) -> (CGPoint, Angle) {
        let p1 = point(at: position)
        let p2 = point(at: (position + 0.01).truncatingRemainder(dividingBy: 1))
        
        let angle = Angle(radians: Double(atan2(p2.y - p1.y, p2.x - p1.x)))
        return (p1, angle)
    }
}

struct OnPath<P: Shape, S: Shape>: Shape {
    var shape: S
    let pathShape: P
    var offset: CGFloat // 0...1
    
    var animatableData: AnimatablePair<CGFloat, S.AnimatableData> {
        get {
            return AnimatablePair(offset, shape.animatableData)
        }
        set {
            offset = newValue.first
            shape.animatableData = newValue.second
        }
    }
    
    func path(in rect: CGRect) -> Path {
        let offset = self.offset.truncatingRemainder(dividingBy: 1)
        let offset2 = (1 + offset + 0.001).truncatingRemainder(dividingBy: 1)
        let path = pathShape.path(in: rect)
        let (point, angle) = path.pointAndAngle(at: offset2)
        
        print(point)
        let shapePath = shape.path(in: rect)
        let size = shapePath.boundingRect.size
        let head = shapePath
            .offsetBy(dx: -size.width / 2, dy: -size.height)
//            .applying(CGAffineTransform(rotationAngle: CGFloat(angle.radians) + .pi / 2))
            .applying(CGAffineTransform(rotationAngle: -offset * 12.0 * CGFloat.pi))
            .offsetBy(dx: point.x , dy: point.y)
        
        var result = Path()
        let trailLenght: CGFloat = 0.06
        let trimmFrom = offset - trailLenght
        if trimmFrom < 0 {
            result.addPath(path.trimmedPath(from: 1 - abs(trimmFrom), to: 1))
        }
        result.addPath(path.trimmedPath(from: max(0, trimmFrom), to: offset))
        result = result.strokedPath(trailStyle)
        result.addPath(head)
        return head
    }
}


struct Loader_Previews: PreviewProvider {
    static var previews: some View {
        Loader()
    }
}
