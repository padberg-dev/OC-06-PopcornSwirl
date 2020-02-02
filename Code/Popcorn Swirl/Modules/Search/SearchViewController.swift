//
//  SearchViewController.swift
//  Popcorn Swirl
//
//  Created by Rafal Padberg on 02.12.19.
//  Copyright © 2019 Rafal Padberg. All rights reserved.
//

import UIKit
import SwiftUI
import Combine

class SearchViewController: BaseViewController<SearchViewUI> {
    
    private var viewModel = SearchViewModel()
    
    var navigationDisposable: AnyCancellable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareUI(view: SearchViewUI(viewModel: viewModel))
        
        navigationDisposable = viewModel.$movieChosen.sink { movieId in
            if movieId.isEmpty { return }
            print("Movie chosen: \(movieId)")
            
            let vc = DetailViewController()
            vc.assignMovieId(id: movieId)
            self.navigationController?.pushViewController(vc, animated: false)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        (tabBarController as? MainTabBarController)?.toggleTabBar(true)
    }
}
