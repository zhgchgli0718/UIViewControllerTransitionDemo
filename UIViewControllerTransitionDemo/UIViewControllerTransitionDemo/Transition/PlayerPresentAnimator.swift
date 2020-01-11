//
//  PlayerPresentAnimator.swift
//  InteractiveViewControllerDemo
//
//  Created by ZhgChgLi on 2019/12/22.
//  Copyright © 2019 ZhgChgLi. All rights reserved.
//

import UIKit

class PlayerPresentAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.4
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toView = transitionContext.view(forKey: .to) else {
            transitionContext.completeTransition(true)
            return
        }
        
        let containerView = transitionContext.containerView
        
        toView.frame.origin.y = UIScreen.main.bounds.size.height
        toView.frame.size.height = UIScreen.main.bounds.size.height - 50
        
        let path = UIBezierPath(roundedRect: toView.bounds, byRoundingCorners: [.topLeft,.topRight], cornerRadii: CGSize(width: 10, height: 10))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        toView.layer.mask = mask
        
        containerView.addSubview(toView)
        
        let duration = transitionDuration(using: transitionContext)
        UIView.animate(withDuration: duration, delay: 0, options: UIView.AnimationOptions.curveLinear, animations: {
            toView.frame.origin.y = UIScreen.main.bounds.size.height - (UIScreen.main.bounds.size.height - 50)
        }) { (finished) in
            let success = !transitionContext.transitionWasCancelled
            transitionContext.completeTransition(success)
        }
        
    }
}
