//
//  DiscoverViewModel.swift
//  Popcorn Swirl
//
//  Created by Rafal Padberg on 03.12.19.
//  Copyright © 2019 Rafal Padberg. All rights reserved.
//

import Foundation
import SwiftUI

class DiscoverViewModel: ObservableObject {
    
    @Published var movieChosen: String = ""
    
    let nowPlayingGroup: DataGroup = DataGroup(type: .nowPlaying)
    let upcomingGroup: DataGroup = DataGroup(type: .upcoming, numberOfMovies: 9) //DataGroup(searchQuery: "Ter", pageNumber: 1)//
    let popularGroup: DataGroup = DataGroup(type: .popular, numberOfMovies: 9)
    let topRatedGroup: DataGroup = DataGroup(type: .topRated, numberOfMovies: 9)
    
    init() {
        nowPlayingGroup.discoverViewModel = self
        upcomingGroup.discoverViewModel = self
        popularGroup.discoverViewModel = self
        topRatedGroup.discoverViewModel = self
    }
    
    public func loadAll() {
        nowPlayingGroup.loadMovies()
        upcomingGroup.loadMovies()
        popularGroup.loadMovies()
        topRatedGroup.loadMovies()
    }
}
