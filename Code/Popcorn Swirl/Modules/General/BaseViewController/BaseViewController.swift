//
//  BaseViewController.swift
//  Popcorn Swirl
//
//  Created by Rafal Padberg on 03.12.19.
//  Copyright © 2019 Rafal Padberg. All rights reserved.
//

import UIKit
import SwiftUI

class BaseViewController<SwiftUIView: View>: UIViewController {
    
    private var swiftUIView: SwiftUIView!
    private var hostView: UIHostingController<SwiftUIView>!
    
    public var uiView: SwiftUIView {
        return hostView.rootView
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        setupUI()
    }
    
    // MARK:- Public Methods
    
    public func prepareUI(view: SwiftUIView) {
        self.swiftUIView = view
    }
    
    // MARK:- Private Methods
    
    private func setupUI() {
        
        hostView = UIHostingController(rootView: swiftUIView)
        hostView.view.frame = self.view.bounds
        self.view.addSubview(hostView.view)
    }
}
