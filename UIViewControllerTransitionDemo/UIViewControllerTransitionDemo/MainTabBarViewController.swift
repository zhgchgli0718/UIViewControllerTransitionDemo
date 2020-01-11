//
//  MainTabBarViewController.swift
//  UIViewControllerTransitionDemo
//
//  Created by ZhgChgLi on 2020/1/10.
//  Copyright © 2020 ZhgChgLi. All rights reserved.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
        // Do any additional setup after loading the view.
    }
    
}

extension MainTabBarViewController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, animationControllerForTransitionFrom fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return FadeInFadeOutTransition()
    }
}
