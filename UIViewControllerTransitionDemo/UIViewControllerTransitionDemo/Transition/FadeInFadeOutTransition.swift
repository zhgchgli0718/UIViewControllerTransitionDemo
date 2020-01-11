//
//  FadeInFadeOutTransition.swift
//  UIViewControllerTransitionDemo
//
//  Created by ZhgChgLi on 2020/1/10.
//  Copyright © 2020 ZhgChgLi. All rights reserved.
//

import UIKit

class FadeInFadeOutTransition: NSObject, UIViewControllerAnimatedTransitioning {
    
    private var animatorForCurrentTransition: UIViewImplicitlyAnimating?

    func interruptibleAnimator(using transitionContext: UIViewControllerContextTransitioning) -> UIViewImplicitlyAnimating {
        if let animatorForCurrentTransition = animatorForCurrentTransition {
            return animatorForCurrentTransition
        }
        
        guard let toView = transitionContext.view(forKey: .to), let fromView = transitionContext.view(forKey: .from) else {
            return UIViewPropertyAnimator()
        }
        
        fromView.alpha = 1
        toView.alpha = 0
        transitionContext.containerView.addSubview(toView)
        
        let animator = UIViewPropertyAnimator(duration: transitionDuration(using: transitionContext), curve: .linear)
        
        animator.addAnimations {
            fromView.alpha = 0
            toView.alpha = 1
        }
        
        animator.addCompletion { (position) in
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
        }
        
        self.animatorForCurrentTransition = animator
        return animator
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.4
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let animator = self.interruptibleAnimator(using: transitionContext)
        animator.startAnimation()
    }
    
    func animationEnded(_ transitionCompleted: Bool) {
        self.animatorForCurrentTransition = nil
    }
    
}
