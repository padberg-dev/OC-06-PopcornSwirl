//
//  SearchFilter.swift
//  Popcorn Swirl
//
//  Created by Rafal Padberg on 22.11.19.
//  Copyright © 2019 Rafal Padberg. All rights reserved.
//

import SwiftUI
import UIKit

enum ChangingFilterType: Int, CaseIterable {
    case none = 0
    case text = 1
    case collection = 2
    case genre = 3
    case year = 4
}

struct SearchFilter: View {
    var collections: [String] = [
        "All Types" , "Upcoming", "Top Rated", "Popular", "Latest", "Now Playing"
    ]
    @State var collectionTitle: String = "All Types"
    
    var genres: [String] = [
        "All Genres" , "Comedy", "Drama", "Action", "Sci-Fi", "Romance", "Fantasy", "Thriller", "Horror", "Sport", "Detective", "Musical"]
    @State var genresTitle: String = "All Genres"
    
    var years: [String] = [
        "All Years" , "60's", "70's", "80's", "90's", "2000's",
        "2010's", "2016", "2017", "2018", "2019"
    ]
    @State var yearsTitle: String = "All Years"
    @State var changingFilter: ChangingFilterType = .none
    @State var searchText: String = ""
    
    @State var searchBlocked: Bool = false
    
    var body: some View {
        VStack(spacing: 0) {
            
            HStack {
                if searchBlocked {
                    Text(searchText.isEmpty ? "Search" : searchText)
                        .font(Font.system(size: 16, weight: .semibold))
                        .foregroundColor(.hex("B6B6B6"))
                        .padding(.horizontal, 20)
                        .opacity(self.searchBlocked ? 1 : 0)
                    Spacer()
                } else {
                    TextField("Search", text: $searchText)
                        .font(Font.system(size: 16, weight: .semibold))
                        .foregroundColor(.hex("B6B6B6"))
                        .padding(.horizontal, 20)
                }
                
                    Image(systemName: "magnifyingglass")
                        .padding(.horizontal, 20)
                        .foregroundColor(.hex("B6B6B6"))
                        .onTapGesture {
                            self.searchBlocked.toggle()
                            print("SEARCH")
                    }
            }
            .frame(height: 40)
            .background(Color.hex("E6E6E6"))
            .cornerRadius(12)
            .padding(.horizontal, 24)
            .padding(.bottom, 12)
            .opacity(self.searchBlocked ? 0.5 : 1)
            .scaleEffect(self.searchBlocked ? 0.7 : 1)
            .animation(.spring())
            
            HStack(spacing: 1) {
                FilterCard(title: self.collectionTitle)
                    .background(self.genresTitle != "All Genres" ? Color.first : Color.white)
                    .animation(.spring())
                    .onTapGesture {
                        print("0")
                        self.changingFilter = self.changingFilter != .collection ? .collection : .none
                }
                FilterCard(title: self.genresTitle)
                    .background(self.searchBlocked ? Color.first : Color.white)
                    .animation(.spring())
                    .onTapGesture {
                        print("1")
                        self.changingFilter = self.changingFilter != .genre ? .genre : .none
                }
                FilterCard(title: self.yearsTitle)
                    .background(self.searchBlocked ? Color.first : Color.white)
                    .animation(.spring())
                    .onTapGesture {
                        print("2")
                        self.changingFilter = self.changingFilter != .year ? .year : .none
                }
            }
            .background(Color.clear)
            .cornerRadius(12)
            .padding(.horizontal, 24)
            .frame(height: 40)
            .shadow(color: Color.black.opacity(0.1), radius: 8, y: 8)
            
            HStack(spacing: 0) {
                FilterCardMore(title: $collectionTitle, showIcons: false, data: collections, changingFilters: $changingFilter)
                    .opacity(self.changingFilter == .collection ? 1 : 0)
                    .scaleEffect(self.changingFilter == .collection ? 1.2 : 0.1, anchor: .top)
                    .animation(.spring())
                
                FilterCardMore(title: $genresTitle, showIcons: true, data: genres, changingFilters: $changingFilter)
                    .opacity(self.changingFilter == .genre ? 1 : 0)
                    .scaleEffect(self.changingFilter == .genre ? 1.2 : 0.1, anchor: .top)
                    .animation(.spring())
                
                FilterCardMore(title: $yearsTitle, showIcons: false, data: years, changingFilters: $changingFilter)
                    .opacity(self.changingFilter == .year ? 1 : 0)
                    .scaleEffect(self.changingFilter == .year ? 1.2 : 0.1, anchor: .top)
                    .animation(.spring())
            }
            .offset(y: -50)
            .padding(.horizontal, 24)
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct FilterCard: View {
    var title: String
    
    var body: some View {
        GeometryReader { proxy in
            HStack {
                Text(self.title)
                    .font(Font.system(size: 12, weight: .bold))
                    .foregroundColor(.gray)
                
                Spacer()
                
                Image(systemName: "chevron.down")
                    .imageScale(.small)
                    .foregroundColor(.hex("d1d1d1"))
            }
            .padding(.leading, 14)
            .padding(.trailing, 10)
        }
    }
}

struct FilterCardMore: View {
    @Binding var title: String
    var showIcons: Bool
    var data: [String]
    
    @Binding var changingFilters: ChangingFilterType
    
    var body: some View {
        GeometryReader { proxy in
            VStack {
                VStack(alignment: .leading, spacing: 4) {
                    
                    HStack {
                    Text(self.title)
                        .font(Font.system(size: 11, weight: .semibold))
                        .foregroundColor(.hex("7F7F7F"))
                        .padding(.leading, 10)
                        .padding(.top, 10)
                        .padding(.bottom, 6)
                        
                    }
                    .onTapGesture {
                        self.changingFilters = .none
                    }
                    
                    Rectangle()
                        .foregroundColor(.hex("EBEBEB"))
                        .frame(height: 1)
                    
                    ForEach(0 ..< self.data.count, id: \.self) { int in
                        
                        VStack(alignment: .leading, spacing: 5) {
                            HStack {
                                if self.showIcons {
                                    Image("\(self.data[int].lowercased())\(self.title == self.data[int] ? "Fill" : "")")
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(height: 16)
                                }
                                
                                Text(self.data[int])
                                    .font(Font.system(size: 8, weight: .semibold))
                                    .foregroundColor(.hex("7F7F7F"))
                            }
                            .padding(.leading, 10)
                            
                            if int != self.data.count - 1 {
                                Rectangle()
                                .foregroundColor(.hex("EBEBEB"))
                                .frame(height: 1)
                            } else {
                                Rectangle()
                                    .foregroundColor(.clear)
                                .frame(height: 2)
                            }
                        }
                        .onTapGesture {
                            self.title = self.data[int]
                            self.changingFilters = .none
                        }
                    }
                }
                .background(Color.white)
                .cornerRadius(12)
                .shadow(color: Color.black.opacity(0.1), radius: 8, y: 8)
                
                Spacer()
            }
        }
    }
}

struct SearchFilter_Previews: PreviewProvider {
    static var previews: some View {
        SearchFilter()
    }
}
