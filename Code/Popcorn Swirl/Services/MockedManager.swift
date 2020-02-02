//
//  MockedManager.swift
//  Popcorn Swirl
//
//  Created by Rafal Padberg on 04.12.19.
//  Copyright © 2019 Rafal Padberg. All rights reserved.
//

import Foundation

class MockedManager {
    
    static func getNowPlaying() -> [ResultObject] {
        
        let path = Bundle.main.path(forResource: "NowPlaying", ofType: "json")!
        let jsonString = try! String(contentsOfFile: path)
        let data = jsonString.data(using: .utf8)!
        
        do {
            let result = try JSONDecoder().decode(ResponseObject.self, from: data)
            return result.results ?? []
        } catch {
            return []
        }
    }
}
