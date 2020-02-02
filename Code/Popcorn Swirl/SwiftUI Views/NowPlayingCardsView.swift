//
//  TopMoviesCardsView.swift
//  Popcorn Swirl
//
//  Created by Rafal Padberg on 17.11.19.
//  Copyright © 2019 Rafal Padberg. All rights reserved.
//

import SwiftUI

struct NowPlayingCardsView: View {
    @ObservedObject var dataGroup: DataGroup
    
    init(dataGroup: DataGroup) {
        self.dataGroup = dataGroup
    }
    
    var loaderType: SwirlLoaderType = SwirlLoaderType.getRandom()
    var numberOfItems: Int = 6
    @State var isMovingLeft: Bool = false
    
    @State var shouldShow: Bool = false
    @State var show = false
    @State var viewState = CGSize.zero
    
    var body: some View {
        ZStack {
            
            SwirlLoader(type: loaderType)
                .frame(width: 100, height: 100)
                .opacity(dataGroup.isLoadingImages ? 1 : 0)
            
            ForEach(0 ..< self.dataGroup.getCount(), id: \.self) { number in
                MovieCard(image: self.dataGroup.getImage(for: number))
                    .rotation3DEffect(Angle(degrees: self.calc3DRotation(for: number)), axis: (x: 0, y: 10, z: 0))
                    .offset(x: self.calcOffsetX(for: number), y: 0)
                    .scaleEffect(self.calcScale(for: number))
                    .opacity(self.dataGroup.isLoadingImages ? 0 : 1)
                    .scaleEffect(self.dataGroup.isLoadingImages ? 0.1 : 1)
                    .animation(.spring())
                    .offset(self.extraOffset(for: number))
                    .zIndex(self.calcZIndex(for: number))
                    .onTapGesture {
                        self.dataGroup.movieTapped(index: self.dataGroup.numberOfMovies - 1 - number)
                }
            }
        }
        .gesture(
            DragGesture(minimumDistance: 10)
                .onEnded{ gesture in
                    let transDiff = gesture.translation.width
                    if abs(transDiff) < 100 || self.shouldShow {
                        return }
                    
                    
                        if transDiff > 0 {
                            self.isMovingLeft = true
                            self.dataGroup.selectedIndex -= self.dataGroup.selectedIndex > 0 ? 1 : 0
                        } else {
                            self.isMovingLeft = false
                            self.dataGroup.selectedIndex += self.dataGroup.selectedIndex >= self.dataGroup.getCount() - 1 ? 0 : 1
                        }
            }
        )
    }
    
    func extraOffset(for index: Int) -> CGSize {
        let index = numberOfItems - index - 1
        if index == self.dataGroup.selectedIndex && self.shouldShow {
            return .init(width: -65, height: -170)
        } else {
            return .zero
        }
    }
    
    func calcZIndex(for index: Int) -> Double {
        let index = numberOfItems - index - 1
        let relativeIndex = index - dataGroup.selectedIndex
        
        if index == dataGroup.selectedIndex {
            return Double(numberOfItems + 1)
        }
        
        if !self.isMovingLeft     {
            if relativeIndex >= 0 {
                return Double(self.numberOfItems - index)
            } else {
                return Double(self.numberOfItems + relativeIndex + 2)
            }
        } else {
            if relativeIndex > 0 {
                return Double(self.numberOfItems - index)
            } else {
                return Double(self.numberOfItems + relativeIndex + 1)
            }
        }
    }
    
    func calc3DRotation(for index: Int) -> Double {
        let index = numberOfItems - index - 1
        let relativeIndex = index - dataGroup.selectedIndex
        
        if relativeIndex == 0 {
            return 0
        } else if relativeIndex > 0 {
            return 0
        } else {
            return 80
        }
    }
    
    func calcOffsetX(for index: Int) -> CGFloat {
        let index = numberOfItems - index - 1
        let relativeIndex = index - dataGroup.selectedIndex
        
        if relativeIndex == 0 {
            return 0
        } else if relativeIndex > 0 {
            return min(CGFloat(relativeIndex) * 50, 100)
        } else {
            let calc = CGFloat(relativeIndex) * 50 - 130
            return max(calc, -360)
        }
    }
    
    func calcScale(for index: Int) -> CGFloat {
        let index = numberOfItems - index - 1
        let relativeIndex = index - dataGroup.selectedIndex
        
        if relativeIndex == 0 {
            return 1
        } else if relativeIndex > 0 {
            return 1 - min(CGFloat(relativeIndex) * 0.12, 0.25)
        } else {
            return 0.8
        }
    }
}

struct MovieCard: View {
    var image: Image
    
    init(image: Image? = nil) {
        self.image = image ?? Image(systemName: "photo")
    }
    
    var body: some View {
        ZStack {
            image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .cornerRadius(32)
                .shadow(radius: 4)
        }
        .frame(width: 228, height: 342)
    }
}

struct TopMoviesCardsView_Previews: PreviewProvider {
    static var previews: some View {
        NowPlayingCardsView(dataGroup: DataGroup(type: .nowPlaying))
    }
}
