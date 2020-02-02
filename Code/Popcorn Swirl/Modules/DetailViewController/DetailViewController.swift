//
//  DetailViewController.swift
//  Popcorn Swirl
//
//  Created by Rafal Padberg on 08/01/2020.
//  Copyright © 2020 Rafal Padberg. All rights reserved.
//

import UIKit
import SwiftUI
import Combine

class DetailViewController: BaseViewController<DetailViewUI> {
    
    private var viewModel = DetailViewModel()
    
    var closeDisposable: AnyCancellable!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareUI(view: DetailViewUI(viewModel: viewModel))
        
        closeDisposable = viewModel.$closeObservable.sink { closedView in
            
            if closedView {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        (tabBarController as? MainTabBarController)?.toggleTabBar(false)
    }
    
    public func assignMovieId(id: String) {
        
        viewModel.movieId = id
        viewModel.loadData()
    }
}
