//
//  AgentRegistStepOneVC.swift
//  RealEstate
//
//  Created by jass Dhariwal on 29/06/23.
//

import UIKit

class AgentRegistStepOneVC: UIViewController {

    @IBOutlet weak var tfLocality: TextFieldCustom!
    @IBOutlet weak var tfAddress: TextFieldCustom!
    @IBOutlet weak var tfContactPersonName: TextFieldCustom!
    @IBOutlet weak var tfAgencyName: TextFieldCustom!
    @IBOutlet weak var tfPricePercentage: TextFieldCustom!
    @IBOutlet weak var tfBusinessDecs: TextFieldCustom!
    @IBOutlet weak var tfOperatingYear: TextFieldCustom!
    
    var userId: Int?
    private var profileModel: ProfileParamApiModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        profileModel = ProfileParamApiModel()
    }
    

    @IBAction func btnNextAtion(_ sender: UIButton){
        
        if tfLocality.text == "" || tfAddress.text == "" || tfContactPersonName.text == "" || tfAgencyName.text == "" || tfPricePercentage.text == "" || tfBusinessDecs.text == "" || tfOperatingYear.text == ""{
            UtilityMangr.shared.showAlert(title: "", msg: "All fields are required", vwController: self)
            return
        }
        
        
        let vc = AgentRegistStepTwoVC.getVC(.Agent)
        profileModel?.user_id = userId
        profileModel?.locality = self.tfLocality.text
        profileModel?.address = self.tfAddress.text
        profileModel?.contact_person_name = tfContactPersonName.text
        profileModel?.company_name = self.tfAgencyName.text
        profileModel?.price = self.tfPricePercentage.text
        profileModel?.business_description = self.tfBusinessDecs.text
        profileModel?.operating_since = self.tfOperatingYear.text
        vc.profileModel = self.profileModel
        self.push(vc)
    }

}
