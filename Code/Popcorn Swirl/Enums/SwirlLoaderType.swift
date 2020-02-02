//
//  SwirlLoaderType.swift
//  Popcorn Swirl
//
//  Created by Rafal Padberg on 08.12.19.
//  Copyright © 2019 Rafal Padberg. All rights reserved.
//

import Foundation

enum SwirlLoaderType: Int, CaseIterable {
    case swirl1 = 0
    case swirl2 = 1
    case swirl3 = 2
    case swirl4 = 3
    case swirl5 = 4
    case swirl6 = 5
    
    static func getRandom() -> SwirlLoaderType {
        let numberOfCases = SwirlLoaderType.allCases.count
        let random = Int.random(in: 0 ..< numberOfCases)
        return SwirlLoaderType(rawValue: random) ?? .swirl1
    }
}
