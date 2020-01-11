//
//  PlayerDismissAnimator.swift
//  InteractiveViewControllerDemo
//
//  Created by ZhgChgLi on 2019/12/21.
//  Copyright © 2019 ZhgChgLi. All rights reserved.
//

import UIKit

class PlayerDismissAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.4
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {

        guard let fromViewController = transitionContext.viewController(forKey: .from),let fromView = transitionContext.view(forKey: .from) else {
            transitionContext.completeTransition(true)
            return
        }

        var fromFinalFrame = transitionContext.finalFrame(for: fromViewController)
        let newFinalOrigin = CGPoint(x: fromFinalFrame.origin.x, y: fromFinalFrame.origin.y + fromFinalFrame.size.height)
        fromFinalFrame.origin = newFinalOrigin

        let duration = transitionDuration(using: transitionContext)
        UIView.animate(withDuration: duration, delay: 0, options: UIView.AnimationOptions.curveLinear, animations: {
            fromView.frame = fromFinalFrame
        }) { (finished) in
            let success = !transitionContext.transitionWasCancelled
            transitionContext.completeTransition(success)
        }
    }
    
}
