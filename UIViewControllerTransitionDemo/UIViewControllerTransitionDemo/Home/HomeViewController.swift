//
//  HomeViewController.swift
//  UIViewControllerTransitionDemo
//
//  Created by ZhgChgLi on 2020/1/10.
//  Copyright © 2020 ZhgChgLi. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    
    @IBAction func itemButtonTapped(_ sender: Any) {
        let homeItemViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "HomeItemViewController")
        self.navigationController?.pushViewController(homeItemViewController, animated: true)
    }
    
    @IBAction func addButtonTapped(_ sender: Any) {
        guard let homeAddViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "HomeAddViewController") as? HomeAddViewController else {
            return
        }
        homeAddViewController.transitioningDelegate = homeAddViewController
        homeAddViewController.modalPresentationStyle = .custom
        self.present(homeAddViewController, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}
