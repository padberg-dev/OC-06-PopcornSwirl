//
//  DiscoverViewUI.swift
//  Popcorn Swirl
//
//  Created by Rafal Padberg on 03.12.19.
//  Copyright © 2019 Rafal Padberg. All rights reserved.
//

import SwiftUI
import Combine

struct DiscoverViewUI: View {
    @ObservedObject var viewModel: DiscoverViewModel
    
    init(viewModel: DiscoverViewModel) {
        self.viewModel = viewModel
    }
    
    var body: some View {
        ZStack {
            ScrollView {
                VStack {
                    
                    HStack {
                        Text("Now Playing")
                            .modifier(HeaderLabel(type: .h1))
                        Spacer()
                    }
                    .padding(.top, 50)
                    .padding(.horizontal, 24)
                    
                    NowPlayingCardsView(dataGroup: viewModel.nowPlayingGroup)
                    
                    ZStack(alignment: .topLeading) {

                        HStack {
                            Text("Upcoming")
                                .modifier(HeaderLabel(type: .h2))
                            Spacer()
                        }
                        .padding(.top, 4)
                        .padding(.horizontal, 24)

                        ScrollViewMovies(dataGroup: viewModel.upcomingGroup)
                    }

                    ZStack(alignment: .topLeading) {
                    HStack {
                        Text("Popular")
                            .modifier(HeaderLabel(type: .h2))
                        Spacer()
                    }
                    .padding(.horizontal, 24)

                        ScrollViewMovies(dataGroup: viewModel.popularGroup)
                    }

                    ZStack(alignment: .topLeading) {
                    HStack {
                        Text("Top Rated")
                            .modifier(HeaderLabel(type: .h2))
                        Spacer()
                    }
                    .padding(.horizontal, 24)

                    ScrollViewMovies(dataGroup: viewModel.topRatedGroup)
                        }
                    
                    Spacer()
                        .padding(.bottom, 60)
                }
            }
        }
        .background(Color.first)
        .edgesIgnoringSafeArea(.top)
    }
}

struct DiscoverViewUI_Previews: PreviewProvider {
    static var previews: some View {
        DiscoverViewUI(viewModel: DiscoverViewModel())
    }
}
