//
//  AgentRegistStepOneVC.swift
//  RealEstate
//
//  Created by jass Dhariwal on 29/06/23.
//

import UIKit

class AgentRegistStepOneVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func btnNextAtion(_ sender: UIButton){
        self.push(AgentRegistStepTwoVC.getVC(.Agent))
    }

}
