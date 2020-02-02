//
//  ScrollTest.swift
//  Popcorn Swirl
//
//  Created by Rafal Padberg on 26.11.19.
//  Copyright © 2019 Rafal Padberg. All rights reserved.
//
import SwiftUI

struct Page: View, Identifiable {
    let id = UUID()

    var body: some View {
        VStack(spacing: 0) {
            Text("Page")
        }
        .frame(width: 414, height: 300, alignment: .leading)
        .background(getRandomColor())
    }
}

struct SwiftUIPagerView<Content: View & Identifiable>: View {

    @State private var index: Int = 0
    @State private var offset: CGFloat = 0

    var pages: [Content]

    var body: some View {
        GeometryReader { geometry in
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .center, spacing: 0) {
                    ForEach(self.pages) { page in
                        page
                            .frame(width: geometry.size.width, height: nil)
                    }
                }
            }
            .content.offset(x: self.offset)
            .frame(width: geometry.size.width, height: nil, alignment: .leading)
            .gesture(DragGesture()
                .onChanged({ value in
                    self.offset = value.translation.width - geometry.size.width * CGFloat(self.index)
                })
                .onEnded({ value in
                    print(geometry.size)
                    
                    if abs(value.predictedEndTranslation.width) >= geometry.size.width / 2 {
                        var nextIndex: Int = (value.predictedEndTranslation.width < 0) ? 1 : -1
                        nextIndex += self.index
                        self.index = nextIndex.keepIndexInRange(min: 0, max: self.pages.endIndex - 1)
                    }
                    withAnimation { self.offset = -geometry.size.width * CGFloat(self.index) }
                })
            )
        }
    }
}

struct ContentView: View {
    var pagerView = SwiftUIPagerView(
        pages: (0..<4).map {
            index in Page()
    })
    
    var body: some View {
        GeometryReader { proxy in
            self.pagerView
            
        }
    }
}

extension Int {
    func keepIndexInRange(min: Int, max: Int) -> Int {
        switch self {
            case ..<min: return min
            case max...: return max
            default: return self
        }
    }
}

func getRandomColor() -> Color {
    let r = Double.random(in: 0..<1)
    let g = Double.random(in: 0..<1)
    let b = Double.random(in: 0..<1)
    return Color(red: r, green: g, blue: b, opacity: 1.0)
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
