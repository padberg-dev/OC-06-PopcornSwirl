//
//  SwirlLoader.swift
//  Popcorn Swirl
//
//  Created by Rafal Padberg on 12.11.19.
//  Copyright © 2019 Rafal Padberg. All rights reserved.
//

import SwiftUI

struct SwirlLoader: View {
    @State var shouldAnimate: Bool = false
    var rotationsCount: Int
    
    var type: SwirlLoaderType
    var offset: CGFloat = 0
    var degrees: Double = 0
    
    init(type: SwirlLoaderType = SwirlLoaderType.getRandom()) {
        self.type = type
        
        switch type {
        case .swirl2:
            self.rotationsCount = 16
        case .swirl3:
            self.rotationsCount = 4
        default:
            self.rotationsCount = 8
        }
    }
    
    var symbols: some View {
        ForEach(0..<self.rotationsCount) { i in
            
            SwirlSymbol(type: self.type,
                        angle: .degrees(-Double(i) / Double(self.rotationsCount)) * 360.0,
                        offset: self.offset,
                        isSecond: self.checkIfDividableBy2(num: i)
            )
                .animation(.linear(duration: 0.7))
            
        }
    }
    
    func checkIfDividableBy2(num: Int) -> Bool {
        return (num % 2) == 0
    }
    
    var body: some View {
        ZStack {
            GeometryReader { geometry in
                self.symbols
                    .scaleEffect(1/2, anchor: .center)
                    .rotationEffect(Angle(degrees: self.shouldAnimate ? 360 : 0))
                    .rotation3DEffect(Angle(degrees: self.degrees), axis: (x: 0, y: 10, z: 0))
            }
        }
        .onAppear() {
            withAnimation(Animation.linear(duration: 2.0).repeatForever(autoreverses: false)) {
                self.shouldAnimate.toggle()
            }
        }
    }
}

struct SwirlSymbol: View {
    let type: SwirlLoaderType
    let angle: Angle
    let offset: CGFloat
    let isSecond: Bool
    
    var body: some View {
        GeometryReader { proxy in
            
            SwirlShape(type: self.type)
                .offset(x: self.offset, y: self.offset)
                .fill(Color.sixth)
                .padding(-60)
                .rotationEffect(self.angle, anchor: .center)
        }
    }
}


struct SwirlShape: Shape {
    let type: SwirlLoaderType
    
    init(type: SwirlLoaderType) {
        self.type = type
    }
    
    func path(in rect: CGRect) -> Path {
        getPath()
            .applying(CGAffineTransform(scaleX: rect.width, y: rect.height))
    }
    
    func getPath() -> Path {
        switch type {
        case .swirl1:
            return SwirlShape.getFirstPath()
        case .swirl2:
            return SwirlShape.getSecondPath()
        case .swirl3:
            return SwirlShape.getThirdPath()
        case .swirl4:
            return SwirlShape.getFourthPath()
        case .swirl5:
            return SwirlShape.getFifthPath()
        default:
            return SwirlShape.getSixthPath()
        }
    }
    
    // MARK: Swirl Loader Shape 1
    
    static func getFirstPath() -> Path {
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
    }
    
    // MARK: Swirl Loader Shape 2
    
    static func getSecondPath() -> Path {
        return Path { path in
            let start = CGPoint(x: 0.4255, y: 0.5285)
            path.move(to: start)
            path.addCurve(to: CGPoint(x: 0.2665, y: 0.5315), control1: CGPoint(x: 0.4109, y: 0.5312), control2: CGPoint(x: 0.3245, y: 0.548))
            path.addCurve(to: CGPoint(x: 0.1105, y: 0.4355), control1: CGPoint(x: 0.2085, y: 0.515), control2: CGPoint(x: 0.1555, y: 0.480))
            path.addCurve(to: CGPoint(x: 0.0425, y: 0.3505), control1: CGPoint(x: 0.0655, y: 0.391), control2: CGPoint(x: 0.057, y: 0.3765))
            path.addLine(to: CGPoint(x: 0.100, y: 0.322))
            path.addCurve(to: CGPoint(x: 0.1865, y: 0.451), control1: CGPoint(x: 0.112, y: 0.352), control2: CGPoint(x: 0.135, y: 0.4075))
            path.addCurve(to: CGPoint(x: 0.316, y: 0.5225), control1: CGPoint(x: 0.238, y: 0.4945), control2: CGPoint(x: 0.2715, y: 0.5135))
            path.addCurve(to: CGPoint(x: 0.4255, y: 0.5285), control1: CGPoint(x: 0.3605, y: 0.5315), control2: CGPoint(x: 0.400, y: 0.5295))
        }
    }
    
    // MARK: Swirl Loader Shape 3
    
    static func getThirdPath() -> Path {
        return Path { path in
            let start = CGPoint(x: 0.654, y: 0.4305)
            path.move(to: start)
            path.addCurve(to: CGPoint(x: 0.6275, y: 0.3255), control1: CGPoint(x: 0.656, y: 0.413), control2: CGPoint(x: 0.661, y: 0.370))
            path.addCurve(to: CGPoint(x: 0.431, y: 0.222), control1: CGPoint(x: 0.594, y: 0.281), control2: CGPoint(x: 0.526, y: 0.222))
            path.addCurve(to: CGPoint(x: 0.2085, y: 0.326), control1: CGPoint(x: 0.336, y: 0.222), control2: CGPoint(x: 0.2635, y: 0.263))
            path.addCurve(to: CGPoint(x: 0.1215, y: 0.548), control1: CGPoint(x: 0.1535, y: 0.389), control2: CGPoint(x: 0.1215, y: 0.4605))
            path.addCurve(to: CGPoint(x: 0.2105, y: 0.800), control1: CGPoint(x: 0.1215, y: 0.6355), control2: CGPoint(x: 0.1575, y: 0.734))
            path.addCurve(to: CGPoint(x: 0.534, y: 0.961), control1: CGPoint(x: 0.2635, y: 0.866), control2: CGPoint(x: 0.381, y: 0.961))
            path.addCurve(to: CGPoint(x: 0.9105, y: 0.776), control1: CGPoint(x: 0.687, y: 0.961), control2: CGPoint(x: 0.8455, y: 0.8595))
            path.addCurve(to: CGPoint(x: 0.565, y: 0.9135), control1: CGPoint(x: 0.8485, y: 0.833), control2: CGPoint(x: 0.730, y: 0.917))
            path.addCurve(to: CGPoint(x: 0.2735, y: 0.781), control1: CGPoint(x: 0.400, y: 0.910), control2: CGPoint(x: 0.3065, y: 0.8195))
            path.addCurve(to: CGPoint(x: 0.187, y: 0.548), control1: CGPoint(x: 0.2405, y: 0.7425), control2: CGPoint(x: 0.193, y: 0.655))
            path.addCurve(to: CGPoint(x: 0.3025, y: 0.3125), control1: CGPoint(x: 0.181, y: 0.441), control2: CGPoint(x: 0.2465, y: 0.355))
            path.addCurve(to: CGPoint(x: 0.447, y: 0.2635), control1: CGPoint(x: 0.3585, y: 0.270), control2: CGPoint(x: 0.390, y: 0.2635))
            path.addCurve(to: CGPoint(x: 0.5925, y: 0.3185), control1: CGPoint(x: 0.504, y: 0.2635), control2: CGPoint(x: 0.5505, y: 0.2785))
            path.addCurve(to: CGPoint(x: 0.654, y: 0.4305), control1: CGPoint(x: 0.6345, y: 0.3585), control2: CGPoint(x: 0.6435, y: 0.3785))
        }
    }
    
    // MARK: Swirl Loader Shape 4
    
    static func getFourthPath() -> Path {
        return Path { path in
            let start = CGPoint(x: 0.500, y: 0.500)
            path.move(to: start)
            path.addCurve(to: CGPoint(x: 0.534, y: 0.392), control1: CGPoint(x: 0.5175, y: 0.4915), control2: CGPoint(x: 0.554, y: 0.4375))
            path.addCurve(to: CGPoint(x: 0.3595, y: 0.2995), control1: CGPoint(x: 0.514, y: 0.3465), control2: CGPoint(x: 0.443, y: 0.295))
            path.addCurve(to: CGPoint(x: 0.1635, y: 0.4125), control1: CGPoint(x: 0.276, y: 0.304), control2: CGPoint(x: 0.212, y: 0.352))
            path.addCurve(to: CGPoint(x: 0.0985, y: 0.5515), control1: CGPoint(x: 0.115, y: 0.473), control2: CGPoint(x: 0.113, y: 0.5025))
            path.addCurve(to: CGPoint(x: 0.094, y: 0.7175), control1: CGPoint(x: 0.084, y: 0.6005), control2: CGPoint(x: 0.0895, y: 0.6895))
            path.addCurve(to: CGPoint(x: 0.112, y: 0.587), control1: CGPoint(x: 0.0985, y: 0.675), control2: CGPoint(x: 0.0975, y: 0.6225))
            path.addCurve(to: CGPoint(x: 0.185, y: 0.4545), control1: CGPoint(x: 0.1265, y: 0.5515), control2: CGPoint(x: 0.138, y: 0.504))
            path.addCurve(to: CGPoint(x: 0.347, y: 0.3665), control1: CGPoint(x: 0.232, y: 0.405), control2: CGPoint(x: 0.2985, y: 0.3665))
            path.addCurve(to: CGPoint(x: 0.4095, y: 0.4155), control1: CGPoint(x: 0.3955, y: 0.3655), control2: CGPoint(x: 0.402, y: 0.4015))
            path.addCurve(to: CGPoint(x: 0.448, y: 0.494), control1: CGPoint(x: 0.4275, y: 0.4635), control2: CGPoint(x: 0.4385, y: 0.488))
            path.addCurve(to: CGPoint(x: 0.500, y: 0.500), control1: CGPoint(x: 0.4575, y: 0.500), control2: CGPoint(x: 0.4825, y: 0.5085))
        }
    }
    
    // MARK: Swirl Loader Shape 5
    
    static func getFifthPath() -> Path {
        return Path { path in
            let start = CGPoint(x: 0.5265, y: 0.583 )
            path.move(to: start)
            path.addCurve(to: CGPoint(x: 0.434, y: 0.626), control1: CGPoint(x: 0.5316, y: 0.5762), control2: CGPoint(x: 0.4835, y: 0.626))
            path.addCurve(to: CGPoint(x: 0.308, y: 0.5645), control1: CGPoint(x: 0.3845, y: 0.626), control2: CGPoint(x: 0.353, y: 0.6075))
            path.addCurve(to: CGPoint(x: 0.2465, y: 0.389), control1: CGPoint(x: 0.263, y: 0.5215), control2: CGPoint(x: 0.2465, y: 0.450))
            path.addCurve(to: CGPoint(x: 0.3415, y: 0.151), control1: CGPoint(x: 0.2465, y: 0.328), control2: CGPoint(x: 0.2645, y: 0.244))
            path.addCurve(to: CGPoint(x: 0.535, y: 0.0375), control1: CGPoint(x: 0.4185, y: 0.058), control2: CGPoint(x: 0.4885, y: 0.0425))
            path.addCurve(to: CGPoint(x: 0.2465, y: 0.188), control1: CGPoint(x: 0.4025, y: 0.0265), control2: CGPoint(x: 0.2945, y: 0.123))
            path.addCurve(to: CGPoint(x: 0.178, y: 0.3845), control1: CGPoint(x: 0.1985, y: 0.253), control2: CGPoint(x: 0.178, y: 0.321))
            path.addCurve(to: CGPoint(x: 0.2305, y: 0.555), control1: CGPoint(x: 0.178, y: 0.448), control2: CGPoint(x: 0.1925, y: 0.500))
            path.addCurve(to: CGPoint(x: 0.4105, y: 0.657), control1: CGPoint(x: 0.2685, y: 0.610), control2: CGPoint(x: 0.3425, y: 0.657))
            path.addCurve(to: start, control1: CGPoint(x: 0.4785, y: 0.657), control2: CGPoint(x: 0.5198, y: 0.5917))
        }
    }
    
    // MARK:- Swirl Loader Shape 6
    
    static func getSixthPath() -> Path {
        return Path { path in
            var start = CGPoint(x: 0.461, y: 0.5385)
            path.move(to: start)
            path.addCurve(to: CGPoint(x: 0.287, y: 0.554), control1: CGPoint(x: 0.446, y: 0.5445), control2: CGPoint(x: 0.391, y: 0.573))
            path.addCurve(to: CGPoint(x: 0.081, y: 0.4645), control1: CGPoint(x: 0.183, y: 0.543), control2: CGPoint(x: 0.134, y: 0.502))
            path.addLine(to: CGPoint(x: 0.0265, y: 0.558))
            path.addCurve(to: CGPoint(x: 0.254, y: 0.6085), control1: CGPoint(x: 0.0855, y: 0.5825), control2: CGPoint(x: 0.152, y: 0.6085))
            path.addCurve(to: start, control1: CGPoint(x: 0.356, y: 0.6085), control2: CGPoint(x: 0.4508, y: 0.5541))
            
            start = CGPoint(x: 0.452, y: 0.5275)
            path.move(to: start)
            path.addCurve(to: CGPoint(x: 0.254, y: 0.4675), control1: CGPoint(x: 0.358, y: 0.518), control2: CGPoint(x: 0.3425, y: 0.5155))
            path.addCurve(to: CGPoint(x: 0.1055, y: 0.3175), control1: CGPoint(x: 0.1655, y: 0.4195), control2: CGPoint(x: 0.141, y: 0.363))
            path.addLine(to: CGPoint(x: 0.0725, y: 0.338))
            path.addCurve(to: CGPoint(x: 0.211, y: 0.4675), control1: CGPoint(x: 0.1115, y: 0.3915), control2: CGPoint(x: 0.129, y: 0.405))
            path.addCurve(to: start, control1: CGPoint(x: 0.293, y: 0.530), control2: CGPoint(x: 0.4405, y: 0.5275))
        }
    }
}

struct SwirlLoader_Previews: PreviewProvider {
    static var previews: some View {
        SwirlLoader()
            .aspectRatio(contentMode: .fit)
    }
}
