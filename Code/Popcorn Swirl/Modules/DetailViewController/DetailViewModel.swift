//
//  DetailViewModel.swift
//  Popcorn Swirl
//
//  Created by Rafal Padberg on 08/01/2020.
//  Copyright © 2020 Rafal Padberg. All rights reserved.
//


import Foundation
import SwiftUI
import Combine

class DetailViewModel: ObservableObject {
    
    @Published var closeObservable: Bool = false
    
    var result: ResultObject?
    var casts: [Cast] = []
    @Published var castsImage: [Image] = []
    @Published var reviews: [Review] = []
    var iconImage: Image = Image(uiImage: UIImage())
    @Published var backdropImage: Image = Image(uiImage: UIImage())
    
    var movieId: String = ""
    
    @Published var commentText: String = "" {
        didSet {
            MovieStore.shared.watchlistMovie(id: String(result?.id ?? 0), title: result?.title ?? "", isWatchlisted: checkedButtons[1], isWatched: checkedButtons[0], comment: commentText)
                hasComment = commentText.count > 0
        }
    }
    
    @Published var isWatchlisted: Bool = false
    @Published var isWatched: Bool = false
    @Published var hasComment: Bool = false
    
    var checkedButtons: [Bool] = [false, false, false] {
        didSet {
            MovieStore.shared.watchlistMovie(id: String(movieId), title: result?.title, isWatchlisted: checkedButtons[1], isWatched: checkedButtons[0], comment: commentText)
        }
    }
    
    public func loadData() {
        if let movie = MovieStore.shared.findMovie(with: movieId) {
            
            if movie.comment?.count ?? 0 > 0 {
                self.commentText = movie.comment!
            }
            checkedButtons = [movie.isWatched, movie.isWatchlisted, movie.hasComment]
            isWatchlisted = movie.isWatchlisted
            isWatched = movie.isWatched
            hasComment = movie.hasComment
        }
        searchForDetails()
        searchForCast()
        searchForReviews()
    }
    
    public func getBudget() -> String {
        
        if result == nil { return " ??" }
        
        if let budget = result?.budget {
            return "$\(budget / 1000000) M"
        } else {
            return " ??"
        }
    }
    
    public func getRevenue() -> String {
        
        if result == nil { return " ??" }
        
        if let revenue = result?.revenue {
            return "$\(revenue / 1000000) M"
        } else {
            return " ??"
        }
    }
    
    public func getCountries() -> [String] {
        
        if result == nil { return [] }
        
        if let array = result?.production_countries {
            var stringArrays = [String]()
            array.forEach { object in
                stringArrays.append(object.iso_3166_1)
            }
            return stringArrays
        } else {
            return []
        }
    }
    
    public func getGenres() -> [String] {
        
        if result == nil { return [] }
        
        if let array = result?.genres {
            var stringArrays = [String]()
            array.forEach { object in
                stringArrays.append(object.name)
            }
            return stringArrays
        } else {
            return []
        }
    }
    
    public func searchForDetails() {
        
        MovieServices.GET.getDetails(id: movieId) { response in
            DispatchQueue.main.async {
                self.result = response
                self.loadImages()
            }
        }
    }
    
    public func searchForCast() {
        
        MovieServices.GET.getCast(id: movieId) { response in
            DispatchQueue.main.async {
                if let res = response {
                    if res.cast.count > 8 {
                        self.casts = Array( res.cast[0..<8])
                        self.castsImage = Array(repeating: Image(uiImage: UIImage()), count: 8)
                    } else {
                        self.casts = res.cast
                        self.castsImage = Array(repeating: Image(uiImage: UIImage()), count: self.casts.count)
                    }
                    self.loadImages(times: min(res.cast.count, 8))
                }
            }
        }
    }
    
    public func searchForReviews() {
        
        MovieServices.GET.getReviews(id: movieId) { response in
            DispatchQueue.main.async {
                if let res = response?.results {
                    self.reviews = res
                }
            }
        }
    }
    
    private func loadImages() {
        
        if let icon = result?.getPosterURL() {
            loadImage(url: icon) { image in
                DispatchQueue.main.async {
                    self.iconImage = image
                }
            }
        }
        
        if let backdrop = result?.getBackdropURL() {
            loadImage(url: backdrop) { image in
                DispatchQueue.main.async {
                    self.backdropImage = image
                }
            }
        }
    }
    
    private func loadImage(url: String, completion: @escaping ((Image) -> Void)) {
        
        let url = URL(string: url)!
        URLSession.shared.dataTask(with: url) { data, response, error in

            guard let data = data else { return }
            
            completion(Image(uiImage: UIImage(data: data) ?? UIImage()))
        }.resume()
    }
    
    private func loadImages(times: Int) {
        
        for i in 0 ..< times {
            
            let str = casts[i].getProfileURL() ?? ""
            if str == "" {
                continue
            }
            
            let url = URL(string: str)!
            
            URLSession.shared.dataTask(with: url) { data, response, error in
                
                guard let data = data else { return }
                
                DispatchQueue.main.asyncAfter(deadline: .now() + Double(i) * 0.5) {
                    
                    self.castsImage[i] = Image(uiImage: UIImage(data: data) ?? UIImage())
                }
                
            }.resume()
        }
    }
}
