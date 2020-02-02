//
//  DataGroup.swift
//  Popcorn Swirl
//
//  Created by Rafal Padberg on 08.12.19.
//  Copyright © 2019 Rafal Padberg. All rights reserved.
//

import UIKit
import SwiftUI

class DataGroup: ObservableObject {
    
    weak var searchViewModel: SearchViewModel?
    weak var discoverViewModel: DiscoverViewModel?
    
    private let type: GroupType
    var numberOfMovies: Int
    
    var searchQuery: String = ""
    var pageNumber: Int = 1 {
        didSet {
            print("PAGE NUMBER CHANGED TO: \(pageNumber)")
            searchViewModel?.changeSelectedPage(to: pageNumber)
        }
    }
    @Published var allPages: Int = 0
    
    @Published var selectedIndex: Int = 0
    
    private var moviesData: [ResultObject] = []
    @Published var imageData: [Image?] = []
    
    @Published var isLoadingImages: Bool = true
    
    init(type: GroupType, numberOfMovies: Int = 6) {
        self.type = type
        self.numberOfMovies = numberOfMovies
    }
    
    init(searchQuery: String, pageNumber: Int) {
        self.type = .search
        self.numberOfMovies = 20
        self.searchQuery = searchQuery
        self.pageNumber = pageNumber
    }
    
    // MARK:- Public Methods
    
    public func movieTapped(index: Int) {
        if !moviesData.isEmpty, let id = moviesData[index].id {
            searchViewModel?.movieChosen = String(id)
            discoverViewModel?.movieChosen = String(id)
        }
    }
    
    public func getCount() -> Int {
        return moviesData.count
    }
    
    public func getImage(for index: Int) -> Image? {
        
        if getCount() == 0 {
            return nil
//            return Image(systemName: "photo")
        }
        let index = moviesData.count - index - 1
        if imageData[index] != nil {
            return imageData[index] ?? Image(systemName: "photo")
        }
        return nil
//        return Image(systemName: "photo")
    }
    
    public func getResult(for index: Int) -> ResultObject? {
        if moviesData.isEmpty { return nil }
        let index = moviesData.count - index - 1
        return moviesData[index]
    }
    
    public func searchForMovies() {
        
        print("Search MOVIES with: \(searchQuery), page: \(pageNumber)")
        MovieServices.GET.searchMovie(for: searchQuery, page: pageNumber) { [weak self] response in
            if let res = response, let array = res.results {
                DispatchQueue.main.async {
                    self?.moviesData = array
                    let total = res.total_pages ?? 1
                    self?.allPages = min(total, 50)
                    self?.numberOfMovies = array.count
                    self?.loadEachImage()
                }
            }
        }
    }
    
    public func loadMovies() {
        
        print("LOAD MOVIES from: .\(self.type)")
        MovieServices.GET.moviesGroup(of: type) { [weak self] response in
            if let res = response, let array = res.results {
                DispatchQueue.main.async {
                    self?.moviesData = Array(array[0..<self!.numberOfMovies])
                    self?.objectWillChange.send()
                    self?.loadEachImage()
                }
            }
        }
    }
    
    // MARK:- Private Methods
    
    private func loadEachImage() {
        
        imageData = Array(repeating: nil, count: getCount())
        
        let loadGroup = DispatchGroup()
        
        var started: Int = getCount()
        var ended: Int = 0
        
        for i in 0 ..< getCount() {
            
            let str = moviesData[i].getPosterURL() ?? ""
            if str == "" {
                self.imageData[i] = Image(systemName: "photo")
                continue
            }
            
            let url = URL(string: str)!
            
            loadGroup.enter()
            URLSession.shared.dataTask(with: url) { data, response, error in
                
                guard let data = data else { return }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + Double(i) * 0.5) {
                    loadGroup.leave()
                    ended += 1
                    print("TYPE \(self.type) | \(ended)-\(started)")
                    
                    self.imageData[i] = Image(uiImage: UIImage(data: data) ?? UIImage())
                }
                
            }.resume()
        }
        
        loadGroup.notify(queue: .main) {
            print("!!! ALL IS DOWNLOADED FROM: .\(self.type)")
            self.isLoadingImages = false
        }
    }
}
