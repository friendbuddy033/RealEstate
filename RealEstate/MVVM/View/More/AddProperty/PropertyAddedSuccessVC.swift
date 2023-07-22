//
//  PropertyAddedSuccessVC.swift
//  RealEstate
//
//  Created by Surinder kumar on 02/07/23.
//

import UIKit

class PropertyAddedSuccessVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnDashboardAction(_ sender: Any) {
        self.popToViewController(ofClass: MoreVC.self)
    }
    
  

}
