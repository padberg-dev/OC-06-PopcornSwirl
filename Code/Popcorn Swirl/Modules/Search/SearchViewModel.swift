//
//  SearchViewModel.swift
//  Popcorn Swirl
//
//  Created by Rafal Padberg on 08.12.19.
//  Copyright © 2019 Rafal Padberg. All rights reserved.
//

import Foundation
import Combine

class SearchViewModel: ObservableObject {
    
    @Published var movieChosen: String = ""
    
    var searchDataGroup: DataGroup = DataGroup(searchQuery: "", pageNumber: 1)
    
    var selectedPage: Int = 1 {
        didSet {
            loadData()
        }
    }
    var numberOfPages: Int = 0
    
    init() {
        searchDataGroup.searchViewModel = self
    }
    
    var searchQuery: String = ""
    var lastSearchQuery: String = ""
    
    public func searchTapped() {
        print("SEARCH")
        if searchQuery.count >= 3 && lastSearchQuery != searchQuery {
            selectedPage = 1
        }
    }
    
    public func changeSelectedPage(to page: Int) {
        if page != selectedPage {
            selectedPage = page
        }
    }
    
    private func loadData() {
        print("LOAD MOVIES")
        searchDataGroup.searchQuery = searchQuery
        searchDataGroup.pageNumber = selectedPage
        searchDataGroup.searchForMovies()
        lastSearchQuery = searchQuery
    }
}
