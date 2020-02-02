//
//  TabBarView.swift
//  Popcorn Swirl
//
//  Created by Rafal Padberg on 20.11.19.
//  Copyright © 2019 Rafal Padberg. All rights reserved.
//

import SwiftUI

// MARK:- TabBarView

struct TabBarView: View {
    
    @ObservedObject var viewModel = TabBarViewModel()
    
    var body: some View {
        GeometryReader { proxy in
            VStack {
                
                ZStack {
                    Image(self.viewModel.popcornIconName)
                        .resizable()
                        .aspectRatio(1, contentMode: .fit)
                        .rotationEffect(Angle(degrees: Double(self.viewModel.selectedIndex * 180)))
                        .padding(4)
                        .offset(x: CGFloat(self.viewModel.selectedIndex - 1) * proxy.size.width / 3, y: -26)
                        .animation(.spring())
                    
                    HStack(spacing: 0) {
                        
                        ForEach(0 ..< self.viewModel.tabTitles.count, id: \.self) { number in
                            
                            TabBarItem(id: number, text: self.viewModel.tabTitles[number], selectedItem: self.$viewModel.selectedIndex)
                        }
                    }
                }
                .background(LinearGradient(gradient: Gradient(colors: [.first, .second]), startPoint: .top, endPoint: .bottom))
                .frame(height: 84)
                .padding(.bottom, 0)
                .offset(y: (proxy.size.height - 83) / 2)
            }
        }
        .background(Color.first)
        .edgesIgnoringSafeArea(.all)
    }
}

// MARK:- TabBarItem

struct TabBarItem: View {
    var id: Int
    var text: String
    
    @Binding var selectedItem: Int
    
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                Text(self.text)
                    .foregroundColor(Color.sixth)
                    .offset(y: self.selectedItem == self.id ? 18 : 28)
                    .font(.headline)
                    .opacity(self.selectedItem == self.id ? 1 : 0)
                    .animation(.spring())
                
                Button(action: {
                    self.selectedItem = self.id
                }) {
                        Image(self.getImageName())
                            .resizable()
                            .foregroundColor(self.selectedItem == self.id ? Color.sixth : Color.third)
                            .scaleEffect(self.selectedItem == self.id ? 1 : 0.9, anchor: .center)
                            .aspectRatio(1, contentMode: .fit)
                            .frame(width: 30)
                            .padding(.top, 0)
                            .offset(y: self.selectedItem == self.id ? -26 : 0)
                            .animation(.spring())
                }
            }
        }
    }
    
    private func getImageName() -> String {
        return self.text.lowercased()
    }
}

// MARK:- Preview

struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView(viewModel: TabBarViewModel())
    }
}
