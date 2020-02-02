//
//  ScrollViewMovies.swift
//  Popcorn Swirl
//
//  Created by Rafal Padberg on 20.11.19.
//  Copyright © 2019 Rafal Padberg. All rights reserved.
//

import SwiftUI

struct ScrollViewMovies: View {
    @ObservedObject var dataGroup: DataGroup
    
    var loaderType: SwirlLoaderType = SwirlLoaderType.getRandom()
    
    var body: some View {
        ZStack {
            
            SwirlLoader(type: loaderType)
                .frame(width: 100, height: 100)
                .opacity(dataGroup.isLoadingImages ? 1 : 0)
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack {
                    ForEach(0 ..< dataGroup.numberOfMovies, id: \.self) { number in
                        // Number in reversed order because of ScrollView
                        SmallMovieCard(id: self.dataGroup.numberOfMovies - 1 - number, image: self.dataGroup.getImage(for: self.dataGroup.numberOfMovies - 1 - number))
                            .opacity(self.dataGroup.isLoadingImages ? 0 : 1)
                            .scaleEffect(self.dataGroup.isLoadingImages ? 0.1 : 1)
                            .onTapGesture {
                                self.dataGroup.movieTapped(index: number)
                        }
                    }
                }
            }
            .frame(height: 254)
            .padding(.horizontal, 24)
        }
    }
}

struct SmallMovieCard: View {
    var id: Int
    var image: Image
    
    init(id: Int, image: Image? = nil) {
        self.id = id
        self.image = image ?? Image(systemName: "photo")
    }
    
    @State var isOnWishlist: Bool = false
    @State var isSelected: Bool = false
    
    var body: some View {
        GeometryReader { proxy in
            ZStack(alignment: .topLeading) {
                WatchlistBadge()
                    .zIndex(3)
                    .offset(y: self.isSelected ? 24 : 45)
                    .frame(height: 44)
                    .opacity(self.isOnWishlist ? 1 : 0)
                    .animation(.spring())
                
                VStack(spacing: 0) {
                    self.image
                        .resizable()
                        .zIndex(2)
                        .frame(width: 133, height: 200)
                        .aspectRatio(2 / 3 ,contentMode: .fit)
                        .cornerRadius(16)
                        .opacity(1)
                        .animation(.spring())
                        .offset(y: self.isSelected ? 24 : 45)
                        .shadow(radius: 4)
//                        .onTapGesture {
//                            if self.isSelected {
//                                self.isSelected.toggle()
//                            }
//                    }
//                    .onLongPressGesture(minimumDuration: 0.2) {
//                        self.isSelected.toggle()
//                    }
                    
                    WathlistRectangle()
                        .zIndex(1)
                        .frame(height: 44)
                        .cornerRadius(12)
                        .onTapGesture {
                            self.isOnWishlist.toggle()
                    }
                    
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(height: 10)
                }
            }
        }
        .frame(width: 133)
        .padding(.horizontal, 5)
    }
}

struct WatchlistBadge: View {
    var body: some View {
        HStack {
            Spacer()
            
            Image("PopCorn1")
                .resizable()
            .frame(width: 32, height: 32)
                .offset(x: 6, y: -14)
        }
    }
}

struct WathlistRectangle: View {
    var body: some View {
        ZStack {
            
            Rectangle()
                .zIndex(1)
                .foregroundColor(wathlistColor)
                .frame(height: 44)
                .cornerRadius(16)
            
            VStack {
                Spacer()
                HStack {
                    Image(systemName: "star.circle")
                        .resizable()
                        .frame(width: 12, height: 12)
                        .foregroundColor(.white)
                    
                    Text("Add to Wishlist")
                        .font(.system(size: 10, weight: .light, design: .rounded))
                        .foregroundColor(.white)
                }
                .padding(.bottom, 4)
            }
            .zIndex(2)
        }
    }
}

struct BlurView: UIViewRepresentable {
    
    let style: UIBlurEffect.Style
    
    func makeUIView(context: UIViewRepresentableContext<BlurView>) -> UIView {
        let view = UIView(frame: .zero)
        view.backgroundColor = .clear
        let blurEffect = UIBlurEffect(style: style)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(blurView, at: 0)
        NSLayoutConstraint.activate([
            blurView.heightAnchor.constraint(equalTo: view.heightAnchor),
            blurView.widthAnchor.constraint(equalTo: view.widthAnchor),
            ])
        return view
    }
    
    func updateUIView(_ uiView: UIView,
                      context: UIViewRepresentableContext<BlurView>) {
        
    }
}

var wathlistColor: Color = Color(red: 216/256, green: 51/256, blue: 0)

struct ScrollViewMovies_Previews: PreviewProvider {
    static var previews: some View {
        ScrollViewMovies(dataGroup: DataGroup(type: .upcoming, numberOfMovies: 12))
    }
}
