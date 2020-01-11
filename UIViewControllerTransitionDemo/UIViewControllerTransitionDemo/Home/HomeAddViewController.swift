//
//  HomeAddViewController.swift
//  UIViewControllerTransitionDemo
//
//  Created by ZhgChgLi on 2020/1/10.
//  Copyright © 2020 ZhgChgLi. All rights reserved.
//

import UIKit

class HomeAddViewController: UIViewController {

    private var pullToDismissInteractive:PullToDismissInteractive!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.pullToDismissInteractive = PullToDismissInteractive(self, self.view)
    }
    
}

extension HomeAddViewController: UIViewControllerTransitioningDelegate {
    
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return pullToDismissInteractive
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return PresentAndDismissTransition(false)
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return PresentAndDismissTransition(true)
    }
    
    func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        
        return nil
    }
}
