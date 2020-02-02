//
//  WatchlistViewController.swift
//  Popcorn Swirl
//
//  Created by Rafal Padberg on 02.12.19.
//  Copyright © 2019 Rafal Padberg. All rights reserved.
//

import UIKit
import SwiftUI
import Combine

class WatchlistViewController: BaseViewController<WatchlistViewUI> {
    
    private var viewModel = WatchlistViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.load()
        prepareUI(view: WatchlistViewUI(viewModel: viewModel))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel.load()
        (tabBarController as? MainTabBarController)?.toggleTabBar(true)
    }
}
