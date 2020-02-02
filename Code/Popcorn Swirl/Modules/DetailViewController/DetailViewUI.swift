//
//  DetailViewUI.swift
//  Popcorn Swirl
//
//  Created by Rafal Padberg on 08/01/2020.
//  Copyright © 2020 Rafal Padberg. All rights reserved.
//

import SwiftUI
import Combine

struct DetailViewUI: View {
    @ObservedObject var viewModel: DetailViewModel
    
    var body: some View {
            ZStack {
                
                MovieDetailView(viewModel: viewModel)
        }
        .background(Color.first)
        .edgesIgnoringSafeArea(.top)
    }
}

struct DetailViewUI_Previews: PreviewProvider {
    static var previews: some View {
        DetailViewUI(viewModel: DetailViewModel())
    }
}
