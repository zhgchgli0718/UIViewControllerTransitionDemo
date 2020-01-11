//
//  MusicViewController.swift
//  UIViewControllerTransitionDemo
//
//  Created by ZhgChgLi on 2020/1/11.
//  Copyright © 2020 ZhgChgLi. All rights reserved.
//

import UIKit

class MusicViewController: UIViewController {

    private var playerPresentInteractor:PlayerInteractor!
    private var playerDismissInteractor:PlayerInteractor!
    private var playerVC:UIViewController!
    
    @IBOutlet weak var miniPlayerView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.playerVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PlayerViewController")
        self.playerVC.modalPresentationStyle = .custom
        self.playerVC.transitioningDelegate = self
        
        playerPresentInteractor = PlayerInteractor(self, self.miniPlayerView, playerVC)
        playerPresentInteractor.wantsInteractiveStart = false
        playerDismissInteractor = PlayerInteractor(playerVC, playerVC.view, nil)
        playerDismissInteractor.wantsInteractiveStart = false
    }
    
    override func viewDidAppear(_ animated: Bool) {

    }
}

extension MusicViewController: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return PlayerPresentAnimator()
    }
    
    func interactionControllerForPresentation(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return playerPresentInteractor
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return PlayerDismissAnimator()
    }
    
    func interactionControllerForDismissal(using animator: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return playerDismissInteractor
    }

}

