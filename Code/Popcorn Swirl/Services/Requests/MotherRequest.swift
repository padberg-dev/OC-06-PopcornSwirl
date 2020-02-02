//
//  MotherRequest.swift
//  Popcorn Swirl
//
//  Created by Rafal Padberg on 04.12.19.
//  Copyright © 2019 Rafal Padberg. All rights reserved.
//

import Foundation


protocol RequestProtocol {
    
    var url: URL { get }
    var queryString: [String: String]? { get }
    var httpMethod: String { get }
    
    func build() -> URLRequest
}


struct MotherRequest: RequestProtocol {
    
    var url: URL
    var queryString: [String : String]?
    var httpMethod: String
    
    public init(url: String, httpMethod: String = "GET", queryString: [String: String]? = nil) {
        
        var query: String = "?api_key=\(MovieServices.apiKeyV3)"
        self.httpMethod = httpMethod
        
        queryString?.forEach { key, value in
            query += "&\(key)=\(value)"
        }
        
        self.url = URL(string: MovieServices.serverBaseURL + url + query)!
    }
    
    func build() -> URLRequest {
        
        var urlRequest = URLRequest(url: self.url)
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequest.httpMethod = self.httpMethod

        return urlRequest
    }
}

extension MovieServices {
    
    static func motherRequest<R: RequestProtocol, D: Decodable>(request: R, completion: @escaping (D?) -> Void) {
        
        let urlRequest = request.build()
        
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            
            if error != nil {
                completion(nil)
                return
            }
            
            guard let data = data else {
                completion(nil)
                return
            }
            
            do {
                let result = try JSONDecoder().decode(D.self, from: data)
                completion(result)
            }
            catch {
                print("DECODE ERROR")
                completion(nil)
            }
            
        }.resume()
    }
}
