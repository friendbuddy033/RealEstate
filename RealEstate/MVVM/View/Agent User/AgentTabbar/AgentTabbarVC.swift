//
//  AgentTabbarVCViewController.swift
//  RealEstate
//
//  Created by jass Dhariwal on 01/07/23.
//

import UIKit

class AgentTabbarVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            if let items = tabBar.items {
                // Setting the title text color of all tab bar items:
                for item in items {
                    item.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .selected)
                    item.setTitleTextAttributes([.foregroundColor: UIColor.white], for: .normal)
                }
            }
        }

}
