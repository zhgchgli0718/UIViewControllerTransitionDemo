//
//  PlayerInteractor.swift
//  InteractiveViewControllerDemo
//
//  Created by ZhgChgLi on 2019/12/21.
//  Copyright © 2019 ZhgChgLi. All rights reserved.
//

import UIKit

class PlayerInteractor: UIPercentDrivenInteractiveTransition {
    
    private var viewController: UIViewController!
    private var presenting: UIViewController? = nil
    private var interactiveView: UIView!
    private let thredhold: CGFloat = 0.4
    
    init(_ viewController: UIViewController, _ interactiveView: UIView, _ presenting: UIViewController? = nil) {
        super.init()
        self.viewController = viewController
        self.presenting = presenting
        self.interactiveView = interactiveView
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(handlePan(_:)))
        panGesture.maximumNumberOfTouches = 1
        self.interactiveView.addGestureRecognizer(panGesture)

        self.wantsInteractiveStart = false
    }
    
    @objc func handlePan(_ sender: UIPanGestureRecognizer) {
        
        switch sender.state {
        case .began:
            
            sender.setTranslation(.zero, in: interactiveView)
            wantsInteractiveStart = true
            if let presenting = presenting {
                viewController.present(presenting, animated: true, completion: nil)
            } else {
                viewController.dismiss(animated: true, completion: nil)
            }
        case .changed:
            let translation = sender.translation(in: interactiveView)
            var y = translation.y
            
            if presenting != nil {
                y = y * -1
            }
            
            if y < 0 {
                sender.setTranslation(.zero, in: interactiveView)
            } else {
                let percentage = abs(y / UIScreen.main.bounds.height)
                print(percentage)
                update(percentage)
            }
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
