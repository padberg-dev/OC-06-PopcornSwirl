//
//  MultipleSelectionControl.swift
//  Popcorn Swirl
//
//  Created by Rafal Padberg on 24.11.19.
//  Copyright © 2019 Rafal Padberg. All rights reserved.
//

import SwiftUI

struct MultipleSelectionControl: View {
    var titles: [String] = ["All", "Watchlisted", "Watched", "Noted"]
    
    @ObservedObject var viewModel: WatchlistViewModel
    
    func toggleFilter(id: Int) {
        
        if id == 0 {
            viewModel.filters[id].toggle()
            for i in 0 ..< viewModel.filters.count {
                viewModel.filters[i] = viewModel.filters[id]
            }
        } else {
            viewModel.filters[id].toggle()
            let count = viewModel.filters.filter { $0 }.count
            if count == 3 {
                viewModel.filters[0].toggle()
            }
        }
    }
    
    var body: some View {
        VStack(spacing: 0) {
            
//            HStack(spacing: 0) {
//
//                GeometryReader { proxy in
//
//                    SingleSelectionCard(id: -1, title: "", selectedId: self.$viewModel.selectedId)
//                            .background(Color.white)
//                            .cornerRadius(8)
//                            .frame(width: proxy.size.width / 3)
//                        .offset(x: CGFloat(self.viewModel.selectedId) * proxy.size.width / 3)
//                            .animation(.spring())
//
//                    SingleSelectionCard(id: 0, title: "Name", selectedId: self.$viewModel.selectedId)
//                        .frame(width: proxy.size.width / 3)
//                        .offset(x: 0)
//                                .onTapGesture {
//                                    self.viewModel.selectedId = 0
//                        }
//
//                    SingleSelectionCard(id: 1, title: "Creation Date", selectedId: self.$viewModel.selectedId)
//                    .frame(width: proxy.size.width / 3)
//                        .offset(x: proxy.size.width / 3)
//                                .onTapGesture {
//                                    self.viewModel.selectedId = 1
//                        }
//
//                    SingleSelectionCard(id: 2, title: "Update Date", selectedId: self.$viewModel.selectedId)
//                        .frame(width: proxy.size.width / 3)
//                        .offset(x: 2 * proxy.size.width / 3)
//                                .onTapGesture {
//                                    self.viewModel.selectedId = 2
//                        }
//                }
//            }
//            .background(Color.hex("b5b5b5"))
//            .cornerRadius(8)
//            .padding(.horizontal, 24)
//            .frame(height: 28)
//            .shadow(color: Color.black.opacity(0.1), radius: 8, y: 8)
//            .padding(.bottom, 12)
            
            HStack(spacing: 1) {
                MultipleSelectionCard(title: self.titles[0], isSelected: self.viewModel.filters[0])
                    .background(self.viewModel.filters[0] ? Color.white : Color.hex("b5b5b5"))
                    .animation(.spring())
                    .onTapGesture {
                        self.toggleFilter(id: 0)
                }
                MultipleSelectionCard(title: self.titles[1], isSelected: self.viewModel.filters[1])
                    .background(self.viewModel.filters[1] ? Color.white : Color.hex("b5b5b5"))
                    .animation(.spring())
                    .onTapGesture {
                        self.toggleFilter(id: 1)
                }
                MultipleSelectionCard(title: self.titles[2], isSelected: self.viewModel.filters[2])
                    .background(self.viewModel.filters[2] ? Color.white : Color.hex("b5b5b5"))
                    .animation(.spring())
                    .onTapGesture {
                        self.toggleFilter(id: 2)
                }
                MultipleSelectionCard(title: self.titles[3], isSelected: self.viewModel.filters[3])
                    .background(self.viewModel.filters[3] ? Color.white : Color.hex("b5b5b5"))
                    .animation(.spring())
                    .onTapGesture {
                        self.toggleFilter(id: 3)
                }
            }
            .background(Color.clear)
            .cornerRadius(8)
            .padding(.horizontal, 24)
            .padding(.vertical, 0)
            .frame(height: 28)
            .shadow(color: Color.black.opacity(0.1), radius: 8, y: 8)
        }
        .frame(height: 40)
    }
}

struct SingleSelectionCard: View {
    var id: Int
    var title: String
    @Binding var selectedId: Int
    
    var body: some View {
        GeometryReader { proxy in
            HStack {
                ZStack {
                    HStack {
                        Text(self.title)
                            .font(Font.system(size: 10, weight: .bold))
                            .foregroundColor(.hex("a2a2a2"))
                            .opacity(self.selectedId == self.id ? 1 : 0)
                            .animation(.spring())
                    }
                    HStack {
                        Text(self.title)
                            .font(Font.system(size: 10, weight: .bold))
                            .foregroundColor(.hex("dadada"))
                            .opacity(self.selectedId == self.id ? 0 : 1)
                            .animation(.spring())
                    }
                }
            }
        }
    }
}

struct MultipleSelectionCard: View {
    var title: String
    var isSelected: Bool
    
    var body: some View {
        GeometryReader { proxy in
            
            ZStack {
                HStack {
                    Text(self.title)
                        .font(Font.system(size: 10, weight: .bold))
                        .foregroundColor(.hex("a2a2a2"))
                        .opacity(self.isSelected ? 1 : 0)
                        .animation(.spring())
                }
                HStack {
                    Text(self.title)
                        .font(Font.system(size: 10, weight: .bold))
                        .foregroundColor(.hex("dadada"))
                        .opacity(self.isSelected ? 0 : 1)
                        .animation(.spring())
                }
            }
            .padding(.leading, 8)
            .padding(.trailing, 8)
        }
    }
}

struct MultipleSelectionControl_Previews: PreviewProvider {
    static var previews: some View {
        MultipleSelectionControl(viewModel: WatchlistViewModel())
    }
}
