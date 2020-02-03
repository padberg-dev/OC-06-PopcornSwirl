//
//  WatchlistViewModel.swift
//  Popcorn Swirl
//
//  Created by Rafal Padberg on 09/01/2020.
//  Copyright © 2020 Rafal Padberg. All rights reserved.
//

import Foundation
import Combine

class WatchlistViewModel: ObservableObject {

    var movies: [Movie] = []
    @Published var filteredMovies: [Movie] = []
    
    @Published var filters: [Bool] = [false, false, false, false] {
        didSet {
            updateFilters()
        }
    }
    
    public func load() {
        
        let store = MovieStore.shared
        self.movies = store.movies
        self.filteredMovies = store.movies
    }
    
    public func getTitleFor(index: Int) -> String {
        return filteredMovies[index].title ?? ""
    }
    
    public func isWatched(index: Int) -> Bool {
        return filteredMovies[index].isWatched
    }
    
    public func isWatchlisted(index: Int) -> Bool {
        return filteredMovies[index].isWatchlisted
    }
    
    public func hasComment(index: Int) -> Bool {
        return filteredMovies[index].hasComment
    }
    
    public func getAllSwitches(for index: Int) -> String {
        let isWatched = filteredMovies[index].isWatched
        let isWatchlisted = filteredMovies[index].isWatchlisted
        let hasComment = filteredMovies[index].hasComment
        
        return "\(isWatched) | \(isWatchlisted) | \(hasComment)"
    }
    
    public func getComment(for index: Int) -> String? {
        return filteredMovies[index].comment
    }
    
    private func updateFilters() {
        var tempMovies = movies
        if filters[1] {
            tempMovies = tempMovies.filter { $0.isWatchlisted }
        }
        if filters[2] {
            tempMovies = tempMovies.filter { $0.isWatched }
        }
        if filters[3] {
            tempMovies = tempMovies.filter { $0.hasComment }
        }
        filteredMovies = tempMovies
    }
}
