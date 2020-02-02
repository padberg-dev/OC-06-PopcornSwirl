//
//  TabTest.swift
//  Popcorn Swirl
//
//  Created by Rafal Padberg on 29/12/2019.
//  Copyright © 2019 Rafal Padberg. All rights reserved.
//

import SwiftUI

struct TabTest: View {
    @ObservedObject var viewModel: DiscoverViewModel
    
    var body: some View {
        TabView {
            DiscoverViewUI(viewModel: viewModel)
                .tabItem {
                    Image(systemName: "1.circle")
                    Text("First")
                }.tag(0)
            
            SearchViewUI(viewModel: SearchViewModel())
                .tabItem {
                    Image(systemName: "2.circle")
                    Text("Second")
                }.tag(1)
            Text("Third View")
                .tabItem {
                    Image(systemName: "3.circle")
                    Text("Third")
                }.tag(1)
        }
    }
}

struct TabTest_Previews: PreviewProvider {
    static var previews: some View {
        TabTest(viewModel: DiscoverViewModel())
    }
}
