//
//  ViewController.swift
//  Popcorn Swirl
//
//  Created by Rafal Padberg on 29.09.19.
//  Copyright © 2019 Rafal Padberg. All rights reserved.
//

import UIKit
import SwiftUI

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        movieDetails()
    }
    
    func textFieldPlus() {
        
        let tFP = TextFieldPlus()
        let host = UIHostingController(rootView: tFP)
        
        host.view.frame = view.bounds
        view.addSubview(host.view)
    }
    
    func movieDetails() {
        
        let mDetails = MovieDetailView(viewModel: DetailViewModel())
        let host = UIHostingController(rootView: mDetails)
        
        host.view.frame = view.bounds
        view.addSubview(host.view)
    }
    
    func showPagination() {
        
        let pagination = PaginationView(viewModel: DataGroup(type: .latest))
        let host = UIHostingController(rootView: pagination)
        
        host.view.frame = view.bounds
        view.addSubview(host.view)
    }
    
    func showTopMoviewsCards() {
        
        let topMovies = NowPlayingCardsView(dataGroup: DataGroup(type: .nowPlaying, numberOfMovies: 6))
        let host = UIHostingController(rootView: topMovies)
        
        host.view.frame = view.bounds
        view.addSubview(host.view)
    }
    
    func searchFilters() {
        
        let topMovies = SearchFilter()
        let host = UIHostingController(rootView: topMovies)
        
        host.view.frame = view.bounds
        view.addSubview(host.view)
    }
    
    func showScrollViewMovies() {
        
        let scrollView = ScrollViewMovies(dataGroup: DataGroup(type: .upcoming, numberOfMovies: 12))
        let host = UIHostingController(rootView: scrollView)
        
        host.view.frame = view.bounds
        view.addSubview(host.view)
    }
    
    func showScrollViewMovies2() {
        
        let scrollView2 = SearchScrollViewMovies(viewModel: DataGroup(type: .latest))
        let host = UIHostingController(rootView: scrollView2)
        
        host.view.frame = view.bounds
        view.addSubview(host.view)
    }
    
    func showTabBarView() {
        
        let tabBar = TabBarView(viewModel: TabBarViewModel())
        let host = UIHostingController(rootView: tabBar)
        
        host.view.frame = view.bounds
        view.addSubview(host.view)
    }
    
    func showSwipeMenu() {
        
        let swipeMenu = SwipeMenu()
        let host = UIHostingController(rootView: swipeMenu)
        
        host.view.frame = view.bounds
        view.addSubview(host.view)
    }
    
    func showLoaders() {
        let loader = PopcornLoader(number: .constant(3))
        let swirlLoader = SwirlLoader()
        let host = UIHostingController(rootView: loader)
        let host2 = UIHostingController(rootView: swirlLoader)
        
        let frameSize = CGSize(width: 100, height: 100)
        
        let origin = CGPoint(
            x: view.frame.width / 2 - frameSize.width,
            y: view.frame.height / 2 - frameSize.height)
        
        host.view.frame = CGRect(origin: origin, size: frameSize)
        host2.view.frame = CGRect(origin: origin, size: frameSize)
        
        //        host2.view.clipsToBounds = true
        
//        view.addSubview(host.view)
                view.addSubview(host2.view)
        
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
        //            host.rootView.number = 1
        //            host2.rootView.rotationCount += 3
                }
        
        for i in 0 ..< 9 {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(i) * 1) {
//                host.rootView.number += 1
                //                host2.rootView.showNumber += 1
                                host2.rootView.offset = CGFloat(i) * -10
//                                host2.rootView.degrees = Double(i) * 20
            }
        }
        for i in 0 ..< 4 {
            DispatchQueue.main.asyncAfter(deadline: .now() + 8.0 + Double(i) * 0.4) {
                host.rootView.number = 3
                host.rootView.number -= Double(i)
                //                host2.rootView.showNumber += 1
                                host2.rootView.offset = CGFloat(i) * -10
                //                host2.rootView.degrees = Double(i) * 20
            }
        }
    }
}

