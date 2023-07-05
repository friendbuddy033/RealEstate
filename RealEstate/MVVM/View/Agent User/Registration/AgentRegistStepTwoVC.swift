//
//  AgentRegistStepTwoVC.swift
//  RealEstate
//
//  Created by jass Dhariwal on 29/06/23.
//

import UIKit

class AgentRegistStepTwoVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func btnSaveAtion(_ sender: UIButton){
        self.push(AgentTabbarVC.getVC(.AgentTabbar))
    }

}
