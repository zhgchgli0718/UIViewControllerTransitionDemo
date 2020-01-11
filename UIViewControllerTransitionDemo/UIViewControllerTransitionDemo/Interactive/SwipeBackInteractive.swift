//
//  SwipeBackInteractive.swift
//  UIViewControllerTransitionDemo
//
//  Created by ZhgChgLi on 2020/1/10.
//  Copyright © 2020 ZhgChgLi. All rights reserved.
//

import UIKit

class SwipeBackInteractive: UIPercentDrivenInteractiveTransition {
    
    private var interactiveView: UIView!
    private var navigationController: UINavigationController!

    private let thredhold: CGFloat = 0.4
    
    convenience init(_ navigationController: UINavigationController, _ interactiveView: UIView) {
        self.init()
        self.interactiveView = interactiveView
        
        self.navigationController = navigationController
        setupPanGesture()
        
        wantsInteractiveStart = false
    }

    private func setupPanGesture() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        panGesture.maximumNumberOfTouches = 1
        interactiveView.addGestureRecognizer(panGesture)
    }

    @objc func handlePan(_ sender: UIPanGestureRecognizer) {
        
        switch sender.state {
        case .began:
            sender.setTranslation(.zero, in: interactiveView)
            wantsInteractiveStart = true
            
            self.navigationController.popViewController(animated: true)
        case .changed:
            let translation = sender.translation(in: interactiveView)
            guard translation.x >= 0 else {
                sender.setTranslation(.zero, in: interactiveView)
                return
            }

            let percentage = abs(translation.x / interactiveView.bounds.width)
            update(percentage)
        case .ended:
            if percentComplete >= thredhold {
                finish()
            } else {
                wantsInteractiveStart = false
                cancel()
            }
        case .cancelled, .failed:
            wantsInteractiveStart = false
            cancel()
        default:
            wantsInteractiveStart = false
            return
        }
    }
}
