//
//  TabBarViewModel.swift
//  Popcorn Swirl
//
//  Created by Rafal Padberg on 02.12.19.
//  Copyright © 2019 Rafal Padberg. All rights reserved.
//

import Foundation
import Combine

class TabBarViewModel: ObservableObject {
    
    @Published var selectedIndex: Int = 0
    
    public let tabTitles: [String] = ["Discover", "Search", "Watchlist"]
    public let popcornIconName: String = "popcornEmpty"
}
