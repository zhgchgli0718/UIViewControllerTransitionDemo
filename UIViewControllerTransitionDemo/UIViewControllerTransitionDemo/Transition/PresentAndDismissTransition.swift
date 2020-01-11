//
//  PresentAndDismissTransition.swift
//  UIViewControllerTransitionDemo
//
//  Created by ZhgChgLi on 2020/1/11.
//  Copyright © 2020 ZhgChgLi. All rights reserved.
//

import UIKit

class DimmingView:UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.black
        self.alpha = 0
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class PresentAndDismissTransition: NSObject, UIViewControllerAnimatedTransitioning {
    
    private var isDismiss:Bool!
    
    convenience init(_ isDismiss:Bool) {
        self.init()
        self.isDismiss = isDismiss
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.4
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        guard let toViewController = transitionContext.viewController(forKey: .to),let fromViewController = transitionContext.viewController(forKey: .from) else {
            return
        }
        
        if !self.isDismiss {
            //Present
            
            toViewController.view.frame.size.height -= 50
            toViewController.view.frame.origin.y = UIScreen.main.bounds.size.height
            transitionContext.containerView.addSubview(toViewController.view)
            
            let toViewpath = UIBezierPath(roundedRect: toViewController.view.bounds, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: 6, height: 6))
            let toViewmask = CAShapeLayer()
            toViewmask.path = toViewpath.cgPath
            toViewController.view.layer.mask = toViewmask
            
            let fromViewpath = UIBezierPath(roundedRect: fromViewController.view.bounds, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: 6, height: 6))
            let fromViewmask = CAShapeLayer()
            fromViewmask.path = fromViewpath.cgPath
            fromViewController.view.layer.mask = fromViewmask
            
            
            let dimmingView = DimmingView(frame: fromViewController.view.frame)
            transitionContext.containerView.insertSubview(dimmingView, belowSubview: toViewController.view)
            
            fromViewController.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            
            UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0, options: [.curveEaseOut], animations: {
                dimmingView.alpha = 0.7
                fromViewController.view.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
                toViewController.view.frame.origin.y = 50
            }) { (_) in
                fromViewController.view.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            }
        } else {
            //Dismiss
            
            let dimmingView = transitionContext.containerView.subviews.first(where: { (view) -> Bool in
                return view is DimmingView
            })
            
            fromViewController.view.frame.origin.y = 50 //or use finalFrame
            
            let fromViewSnpaShot = fromViewController.view.snapshotView(afterScreenUpdates: false)
            
            if let fromViewSnpaShot = fromViewSnpaShot {
                fromViewController.view.isHidden = true
                fromViewSnpaShot.frame = fromViewController.view.frame
                transitionContext.containerView.addSubview(fromViewSnpaShot)
            }
            
            dimmingView?.alpha = 0.7
            toViewController.view.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            
            
            UIView.animate(withDuration: transitionDuration(using: transitionContext), delay: 0, options: [.curveLinear], animations: {
                dimmingView?.alpha = 0
                fromViewSnpaShot?.frame.origin.y = UIScreen.main.bounds.size.height
                toViewController.view.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            }) { (_) in
                if (!transitionContext.transitionWasCancelled) {
                    toViewController.view.transform = .identity
                    dimmingView?.removeFromSuperview()
                    toViewController.view.layer.mask = nil
                }
                fromViewSnpaShot?.removeFromSuperview()
                fromViewController.view.isHidden = false
                transitionContext.completeTransition(!transitionContext.transitionWasCancelled)
            }
        }
        
    }
    
}
