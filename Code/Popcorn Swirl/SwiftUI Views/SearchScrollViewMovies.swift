//
//  ScrollViewMovies2.swift
//  Popcorn Swirl
//
//  Created by Rafal Padberg on 21.11.19.
//  Copyright © 2019 Rafal Padberg. All rights reserved.
//

import SwiftUI

struct SearchScrollViewMovies: View {
    
    @ObservedObject var viewModel: DataGroup
    
    var loaderType: SwirlLoaderType = SwirlLoaderType.getRandom()
    
    func getRange() -> [[Int]] {
        var array: [[Int]] = []
        var workingArray: [Int] = []
        for i in 0 ..< viewModel.numberOfMovies {
            workingArray.append(i)
            if workingArray.count == 2 {
                array.append(workingArray)
                workingArray.removeAll()
            }
        }
        return array
    }
    
    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                
                ScrollView(.vertical) {
                    
                    ForEach(getRange(), id: \.self) { i in
                        HStack {
                            ForEach(i, id: \.self) { num in
                                SmallMovieCard2(
                                    id: self.viewModel.numberOfMovies - 1 - num,
                                    result: self.viewModel.getResult(for: self.viewModel.numberOfMovies - 1 - num),
                                    image: self.viewModel.getImage(for: self.viewModel.numberOfMovies - 1 - num))
                                    .onTapGesture {
                                        self.viewModel.movieTapped(index: num)
                                }
                            }
                        }
                        .frame(width: UIScreen.main.bounds.width)
                    }
                    .padding(.bottom, 40)
                }
                
                ZStack() {
                    Rectangle()
                        .foregroundColor(.first)

                    Text("Search for a movie!")
                        .modifier(HeaderLabel(type: .h1))
                }
                .opacity(viewModel.getCount() == 0 ? 1 : 0)
                .animation(.default)
            }
        }
    }
}

struct SmallMovieCard2: View {
    var id: Int
    var result: ResultObject?
    var image: Image
    
    init(id: Int, result: ResultObject? = nil, image: Image? = nil) {
        self.id = id
        self.result = result ?? ResultObject(poster_path: "", overview: "", release_date: "", genre_ids: [], genres: nil, id: nil, original_title: "", original_language: "", title: "", backdrop_path: "", popularity: nil, vote_count: nil, vote_average: nil, production_countries: nil, budget: nil, revenue: nil, runtime: nil)
        self.image = image ?? Image(uiImage: UIImage())
        self.shouldShow = image != nil
    }
    
    var shouldShow: Bool = false
    
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
                        .frame(width: 150, height: 192)
                        .cornerRadius(12)
                        .offset(y: self.isSelected ? 24 : 45)
                        .opacity(self.shouldShow ? 1 : 0)
                        .scaleEffect(self.shouldShow ? 1 : 0.2)
                        .shadow(radius: 4)
                        .animation(.spring())
//                        .onTapGesture {
//                            if self.isSelected {
//                                self.isSelected.toggle()
//                            }
//                    }
//                    .onLongPressGesture(minimumDuration: 0.1) {
//                        self.isSelected.toggle()
//                    }
//
                    WathlistRectangle()
                        .zIndex(1)
                        .frame(height: 44)
                        .cornerRadius(12)
                        .opacity(self.isSelected ? 1 : 0)
                        .animation(.default)
                        .onTapGesture {
                            self.isOnWishlist.toggle()
                    }
                    
                    Spacer()
                    
                    HStack {
                        Text(self.result?.original_title ?? "")
                        .opacity(self.shouldShow ? 1 : 0)
                            .font(Font.system(size: 14, weight: .bold))
                        Spacer()
                    }
                    
                    HStack {
                        Text(self.result?.getDescription() ?? "")
                        .opacity(self.shouldShow ? 1 : 0)
                            .font(Font.system(size: 12, weight: .light))
                        Spacer()
                    }
                }
            }
        }
        .frame(width: 150, height: 240)
        .padding(.horizontal, 6)
    }
}

struct ScrollViewMovies2_Previews: PreviewProvider {
    static var previews: some View {
        SearchScrollViewMovies(viewModel: DataGroup(type: .latest))
    }
}
