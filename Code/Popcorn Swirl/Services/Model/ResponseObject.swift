//
//  ResponseObject.swift
//  Popcorn Swirl
//
//  Created by Rafal Padberg on 04.12.19.
//  Copyright © 2019 Rafal Padberg. All rights reserved.
//

import Foundation

struct ResponseObject: Decodable {
    
    let page: Int?
    let results: [ResultObject]?
    let dates: DateObject?
    let total_pages: Int?
    let total_results: Int?
}

struct ResultObject: Decodable {
    
    let poster_path: String?
    let overview: String?
    let release_date: String?
    let genre_ids: [Int]?
    let genres: [GenreObject]?
    let id: Int?
    let original_title: String?
    let original_language: String?
    let title: String?
    let backdrop_path: String?
    let popularity: Double?
    let vote_count: Int?
    let vote_average: Double?
    let production_countries: [ProductionCountry]?
    let budget: Int?
    let revenue: Int?
    let runtime: Int?
    
    func getBackdropURL(for size: BackdropSizes = .w780) -> String? {
        if let path = self.backdrop_path {
            return MovieServices.imageBaseURL + size.rawValue + path
        }
        return nil
    }
    
    func getPosterURL(for size: PosterSizes = .w342) -> String? {
        if let path = self.poster_path {
            return MovieServices.imageBaseURL + size.rawValue + path
        }
        return nil
    }
    
    public func getDescription() -> String {
        let genre = genre_ids != nil && genre_ids!.count > 1 ? String(genre_ids!.first!) : ""
        let date = release_date != nil ? (release_date! != "" ? release_date! + " • " : "") : ""
        let lang = original_language != nil ? original_language! : ""
        
        return "\(genre)\(date)\(lang)"
    }
}

struct CastObject: Decodable {
    
    let id: Int?
    let cast: [Cast]
}

struct Cast: Decodable {
    let cast_id: Int?
    let character: String?
    let name: String?
    let profile_path: String?
    
    func getProfileURL(for size: ProfileSizes = .w185) -> String? {
        if let path = self.profile_path {
            return MovieServices.imageBaseURL + size.rawValue + path
        }
        return nil
    }
}

struct ProductionCountry: Decodable {
    
    let iso_3166_1: String
    let name: String
}

struct GenreObject: Decodable {
    
    let id: Int
    let name: String
}

struct DateObject: Decodable {
    
    let maximum: String?
    let minimum: String?
}

enum BackdropSizes: String {
    case w300
    case w780
    case w1280
    case original
}

enum LogoSizes: String {
    case w45
    case w92
    case w154
    case w185
    case w300
    case w500
    case original
}

enum PosterSizes: String {
    case w92
    case w154
    case w185
    case w342
    case w500
    case w780
    case original
}

enum ProfileSizes: String {
    case w45
    case w185
    case w300
    case original
}

struct Review: Decodable {
    let author: String?
    let content: String?
}

struct ReviewObject: Decodable {
    let id: Int?
    let page: Int?
    let results: [Review]?
    let total_pages: Int?
    let total_results: Int?
}
