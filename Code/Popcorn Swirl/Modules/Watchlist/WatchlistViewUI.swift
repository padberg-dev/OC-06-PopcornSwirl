//
//  WatchlistViewUI.swift
//  Popcorn Swirl
//
//  Created by Rafal Padberg on 09/01/2020.
//  Copyright © 2020 Rafal Padberg. All rights reserved.
//

import SwiftUI

struct WatchlistViewUI: View {
    @ObservedObject var viewModel: WatchlistViewModel
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                
                VStack(spacing: 0) {
                    Text("Watchlist")
                        .modifier(HeaderLabel(type: .h1))
                        .padding(.top, 30)
                    
                    MultipleSelectionControl(viewModel: viewModel)
                }
                .frame(height: 140)
                .background(Color.first)
                
                List {
                    ForEach(0 ..< viewModel.filteredMovies.count, id: \.self) { id in
                        
                        
                        VStack(spacing: 0) {
                            HStack(spacing: 0) {
                                Text(self.viewModel.getTitleFor(index: id))
                                    .modifier(HeaderLabel(type: .h3))
                                
                                Spacer()
                                
                                //                            Text(self.viewModel.getAllSwitches(for: id))
                            }
                            
                            if self.viewModel.getComment(for: id) != nil {
                                
                                HStack(spacing: 0) {
                                    Text(self.viewModel.getComment(for: id) ?? "")
                                        .font(.footnote)
                                    
                                    Spacer()
                                }
                            }
                        }
                    }
                }
            }
            .edgesIgnoringSafeArea(.top)
        }
    }
}

struct WatchlistViewUI_Previews: PreviewProvider {
    static var previews: some View {
        WatchlistViewUI(viewModel: WatchlistViewModel())
    }
}
