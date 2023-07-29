//
//  RealEstateTabbarVC.swift
//  RealEstate
//
//  Created by Surinder kumar on 23/06/23.
//

import UIKit

class RealEstateTabbarVC: UITabBarController {

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
