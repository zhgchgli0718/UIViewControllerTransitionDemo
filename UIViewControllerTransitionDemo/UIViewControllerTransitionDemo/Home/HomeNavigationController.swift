//
//  HomeNavigationController.swift
//  UIViewControllerTransitionDemo
//
//  Created by ZhgChgLi on 2020/1/10.
//  Copyright © 2020 ZhgChgLi. All rights reserved.
//

import UIKit

class HomeNavigationController: UINavigationController {

    private var swipeBackInteractive:SwipeBackInteractive!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.swipeBackInteractive = SwipeBackInteractive(self, self.view)
        self.delegate = self
        self.transitioningDelegate = self
        // Do any additional setup after loading the view.
    }

}

extension HomeNavigationController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        if operation == .pop {
            return SlideFromLeftToRightTransition()
        }
        
        return nil
    }
    
    func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        
        if animationController is SlideFromLeftToRightTransition {
            return self.swipeBackInteractive
        }
        
        return nil
    }
}

extension HomeNavigationController: UIViewControllerTransitioningDelegate {
    
}
