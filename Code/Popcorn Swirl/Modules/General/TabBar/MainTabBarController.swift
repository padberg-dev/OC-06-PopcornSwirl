//
//  MainTabBarController.swift
//  Popcorn Swirl
//
//  Created by Rafal Padberg on 02.12.19.
//  Copyright © 2019 Rafal Padberg. All rights reserved.
//

import UIKit
import SwiftUI
import Combine

class MainTabBarController: UITabBarController, UITabBarControllerDelegate {
    
    // MARK:- Private Properties
    
    private var tabBarViewModel: TabBarViewModel = TabBarViewModel()
    private var didChangeIndexObserver: AnyCancellable!
    
    private var tabBarHost: UIHostingController<TabBarView>!
    
    // MARK:- Initializers
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        tabBarHost = UIHostingController(rootView: TabBarView(viewModel: tabBarViewModel))
        tabBarHost.view.frame = self.tabBar.frame
        
        view.addSubview(tabBarHost.view)
        setupObservers()
        
        selectedIndex = 0
    }
    
    // MARK:- Public Methods
    
    public func toggleTabBar(_ shouldShow: Bool) {
        self.tabBar.alpha = shouldShow ? 1 : 0
        self.tabBarHost?.view.alpha = shouldShow ? 1 : 0
    }
    
    // MARK:- Private Methods
    
    private func setupObservers() {
        
        didChangeIndexObserver = tabBarViewModel.$selectedIndex
            .sink(receiveValue: { selectedIndex in
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                    self.changeTabBarTo(index: selectedIndex)
                }
            })
    }
    
    private func changeTabBarTo(index: Int) {
        selectedIndex = index
    }
    
    // MARK:- Static Methods
    
    static func create() -> MainTabBarController {
        
        let tBController = MainTabBarController()
        
        let discoverVC = DiscoverViewController()
        
        tBController.viewControllers = [
            MainNavigationController(rootViewController: discoverVC),
            MainNavigationController(rootViewController: SearchViewController()),
            MainNavigationController(rootViewController: WatchlistViewController())
        ]
        return tBController
    }
}
