//
//  HomeItemViewController.swift
//  UIViewControllerTransitionDemo
//
//  Created by ZhgChgLi on 2020/1/10.
//  Copyright © 2020 ZhgChgLi. All rights reserved.
//

import UIKit

class HomeItemViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.transitionCoordinator?.animate(alongsideTransition: { (context) in
            
        }, completion: { (context) in
            
        })
        // Do any additional setup after loading the view.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
