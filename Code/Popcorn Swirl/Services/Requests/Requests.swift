//
//  Requests.swift
//  Popcorn Swirl
//
//  Created by Rafal Padberg on 04.12.19.
//  Copyright © 2019 Rafal Padberg. All rights reserved.
//

import Foundation

extension MovieServices {
    
    public struct GET {
        
        static func getReviews(id: String, completion: @escaping ((ReviewObject?) -> Void)) {
            
            let request = MotherRequest(url: "/movie/\(id)/reviews")
            MovieServices.motherRequest(request: request) { (result: ReviewObject?) in
                completion(result)
            }
        }
        
        static func getCast(id: String, completion: @escaping ((CastObject?) -> Void)) {
            
            let request = MotherRequest(url: "/movie/\(id)/credits")
            MovieServices.motherRequest(request: request) { (result: CastObject?) in
                completion(result)
            }
        }
        
        static func getDetails(id: String, completion: @escaping ((ResultObject?) -> Void)) {
            
            let request = MotherRequest(url: "/movie/\(id)")
            MovieServices.motherRequest(request: request) { (result: ResultObject?) in
                completion(result)
            }
        }
        
        static func searchMovie(for query: String, page: Int, completion: @escaping ((ResponseObject?) -> Void)) {
            
            let queryString: [String : String] = ["query": query, "page": String(page)]
            let request = MotherRequest(url: "/search/movie", queryString: queryString)
            
            MovieServices.motherRequest(request: request) { (result: ResponseObject?) in
                completion(result)
            }
        }
        
        static func moviesGroup(of type: GroupType, completion: @escaping ((ResponseObject?) -> Void)) {
            
            var request: MotherRequest!
            switch type {
            case .nowPlaying:
                request = MotherRequest(url: "/movie/now_playing", queryString: ["page": "1"])
            case .upcoming:
                request = MotherRequest(url: "/movie/upcoming", queryString: ["page": "1"])
            case .popular:
                request = MotherRequest(url: "/movie/popular", queryString: ["page": "1"])
            case .topRated:
                request = MotherRequest(url: "/movie/top_rated", queryString: ["page": "1"])
            default:
                request = MotherRequest(url: "/movie/now_playing", queryString: ["page": "1"])
            }
            
            MovieServices.motherRequest(request: request) { (result: ResponseObject?) in
                completion(result)
            }
        }
    }
}
