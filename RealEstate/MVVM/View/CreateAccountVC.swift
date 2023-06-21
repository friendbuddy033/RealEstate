//
//  CreateAccountVC.swift
//  RealEstate
//
//  Created by Surinder kumar on 21/06/23.
//

import UIKit

class CreateAccountVC: UIViewController {

    @IBOutlet weak var vwBg: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        vwBg.roundCorners(with: [.layerMinXMinYCorner,.layerMaxXMinYCorner], radius: 45)
    }

}
