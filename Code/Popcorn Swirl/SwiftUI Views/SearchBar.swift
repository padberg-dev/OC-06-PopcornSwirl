//
//  SearchBar.swift
//  Popcorn Swirl
//
//  Created by Rafal Padberg on 07.01.19.
//  Copyright © 2019 Rafal Padberg. All rights reserved.
//

import SwiftUI
import UIKit

struct SearchBar: View {
    
    @ObservedObject var viewModel: SearchViewModel
    
    var body: some View {
        VStack(spacing: 0) {
            
            HStack {
                
                TextField("Search", text: $viewModel.searchQuery)
                        .font(Font.system(size: 16, weight: .semibold))
                        .foregroundColor(.hex("B6B6B6"))
                        .padding(.horizontal, 20)
                
                    Image(systemName: "magnifyingglass")
                        .padding(.horizontal, 20)
                        .foregroundColor(.hex("B6B6B6"))
                        .onTapGesture {
                            self.viewModel.searchTapped()
                    }
            }
            .frame(height: 40)
            .background(Color.hex("E6E6E6"))
            .cornerRadius(12)
            .padding(.horizontal, 24)
            .padding(.bottom, 12)
            .opacity(1)
            .scaleEffect(1)
            .animation(.spring())
            
            Spacer()
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(viewModel: SearchViewModel())
    }
}
