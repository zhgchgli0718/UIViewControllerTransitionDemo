//
//  PullToDismissInteractive.swift
//  UIViewControllerTransitionDemo
//
//  Created by ZhgChgLi on 2020/1/11.
//  Copyright © 2020 ZhgChgLi. All rights reserved.
//

import UIKit

class PullToDismissInteractive: UIPercentDrivenInteractiveTransition {
    
    private var interactiveView: UIView!
    private var presented: UIViewController!
    private var completion:(() -> Void)?
    private let thredhold: CGFloat = 0.4
    
    convenience init(_ presented: UIViewController, _ interactiveView: UIView,_ completion:(() -> Void)? = nil) {
        self.init()
        self.interactiveView = interactiveView
        self.completion = completion
        self.presented = presented
        setupPanGesture()
        
        wantsInteractiveStart = false
    }

    private func setupPanGesture() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        panGesture.maximumNumberOfTouches = 1
        panGesture.delegate = self
        interactiveView.addGestureRecognizer(panGesture)
    }

    @objc func handlePan(_ sender: UIPanGestureRecognizer) {
        switch sender.state {
        case .began:
            sender.setTranslation(.zero, in: interactiveView)
            wantsInteractiveStart = true
            
            self.presented.dismiss(animated: true, completion: self.completion)
        case .changed:
            let translation = sender.translation(in: interactiveView)
            guard translation.y >= 0 else {
                sender.setTranslation(.zero, in: interactiveView)
                return
            }

            let percentage = abs(translation.y / interactiveView.bounds.height)
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

extension PullToDismissInteractive: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        if let scrollView = otherGestureRecognizer.view as? UIScrollView {
            if scrollView.contentOffset.y <= 0 {
                return true
            } else {
                return false
            }
        }
        return true
    }
    
}
