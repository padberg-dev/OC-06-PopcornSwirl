//
//  MainNavigationController.swift
//  Popcorn Swirl
//
//  Created by Rafal Padberg on 02.12.19.
//  Copyright © 2019 Rafal Padberg. All rights reserved.
//

import UIKit

class MainNavigationController: UINavigationController {

    override func viewDidLoad() {
            super.viewDidLoad()
            
//            delegate = self
            self.setNavigationBarHidden(true, animated: false)
        }
        
        func setup() {
            
//            let backImage = UIImage(named: "back")
//            navigationBar.backIndicatorImage = backImage
//            navigationBar.backIndicatorTransitionMaskImage = backImage
//            navigationBar.backItem?.title = ""
//
//            navigationBar.isHidden = false
//            navigationBar.isTranslucent = false
//            navigationBar.barTintColor = UIColor.SolidColors.pureWhite
//            navigationBar.tintColor = UIColor.Greys.blueyGrey
//            navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.Greys.dark,
//                                                 NSAttributedString.Key.font: UIFont.SofiaProBold(size: 17)]
//            navigationBar.setBackgroundImage(UIImage(), for: .any, barMetrics: .default)
//            navigationBar.shadowImage = UIImage()
        }
    }

    //handle animated transition between view controllers
//    extension BaseNavigationController: UINavigationControllerDelegate {
//        func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//            if operation == .push {
//                //SHOW target VC
//                let vc = (toVC as? AnimatedTransitionViewController)
//                vc?.assignDependecies(presenting: true)
//                return vc
//            } else {
//                //HIDE target VC
//                let vc = (toVC as? AnimatedTransitionViewController)
//                vc?.assignDependecies(presenting: false)
//                return vc
//            }
//        }
//        
//        func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
//            return interactionController
//        }
//    }
//
//    extension BaseNavigationController {
//        
//        // When going back from anywhere in Home/Start stop listening to WebSockets by using this function
//        // If going back without wanting to shut down WS use ususal popViewController or popToRootViewController
//        func popToRootAndDisconnect(animated: Bool) {
//            
//            DispatchQueue.main.async {
//                self.tabBar?.stopWS()
//            }
//            self.popToRootViewController(animated: animated)
//        }
//    }
