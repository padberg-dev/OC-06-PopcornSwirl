//
//  SearchViewUI.swift
//  Popcorn Swirl
//
//  Created by Rafal Padberg on 08.12.19.
//  Copyright © 2019 Rafal Padberg. All rights reserved.
//

import SwiftUI
import Combine

struct SearchViewUI: View {
    @ObservedObject var viewModel: SearchViewModel
    
    var body: some View {
            ZStack {
                VStack(spacing: 0) {
                    
                Rectangle()
                    .fill(Color.first)
                    .padding(.top, 50)
                    .frame(height: 98)
                
                    SearchScrollViewMovies(viewModel: viewModel.searchDataGroup)
                        
                    PaginationView(viewModel: viewModel.searchDataGroup)
                            .padding(.top, 20)
                            .padding(.bottom, 80)
                }
                
                SearchBar(viewModel: viewModel)
                    .padding(.top, 50)
        }
        .background(Color.first)
        .edgesIgnoringSafeArea(.top)
    }
}

struct SearchViewUI_Previews: PreviewProvider {
    static var previews: some View {
        SearchViewUI(viewModel: SearchViewModel())
    }
}
