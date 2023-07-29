//
//  AgentRegistStepTwoVC.swift
//  RealEstate
//
//  Created by jass Dhariwal on 29/06/23.
//

import UIKit

class AgentRegistStepTwoVC: UIViewController {

    @IBOutlet weak var tblVw: UITableView!{
        didSet{
            tblVw.delegate = self
            tblVw.dataSource = self
            tblVw.registerNib(cell: TagTblCell.self)
        }
    }
    
    private enum headerTiles : String,CaseIterable{
        case TransactionType = "Transaction Type"
        case PropertyType = "Types of Property"
    }
    
    private var propertyArray : [AddPropertyModel]?
    
//    var userId : Int = 0
    var profileModel: ProfileParamApiModel?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setUI()
    }
    

    @IBAction func btnSaveAtion(_ sender: UIButton){
//        self.push(AgentTabbarVC.getVC(.AgentTabbar))
        self.updateProfile()
    }

}
//MARK: SETUI
extension AgentRegistStepTwoVC{
    
    func setUI(){
        let TransactionType = AddPropertyModel(headerTitle: headerTiles.TransactionType.rawValue,features: ["Rent","Pre-Launch","Original Booking","Resale","Other"])
        let propertType = AddPropertyModel(headerTitle: headerTiles.PropertyType.rawValue,features: ["Villa","Residential Plot","Residential House","Apartment","Residential House","Villa","Apartment","Residential House","Villa"])
        
        propertyArray = [TransactionType,propertType]
    }
    
}
//MARK: - TABLEVIEW DELEGATE AND DATASOURCE
extension AgentRegistStepTwoVC:UITableViewDelegate,UITableViewDataSource, TagTableDelegates{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return propertyArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TagTblCell", for: indexPath) as! TagTblCell
        cell.selectionStyle = .none
        cell.section = indexPath.section
        cell.delegate = self
        
        let tags = propertyArray?[indexPath.section].features ?? []
        cell.vwTag.addTags(tags)
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let vw = HeaderView.instance
        vw.lblTitle.text = propertyArray?[section].headerTitle ?? ""
        vw.lblTitle.font = UIFont(name: FontName.semiBold, size: 18)
        vw.lblTitle.textColor = AppColor.themeColor
        vw.btnSeeMore.isHidden = true
        return vw
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 45
    }
    
    func didSelectTag(section: Int, tag: String) {
        if section == 0 {
            self.profileModel?.transaction_type = tag
        }else{
            self.profileModel?.type_of_property = tag
        }
    }
    
}
extension AgentRegistStepTwoVC
{
    
    private func updateProfile(){
        
        let params = ProfileParamApiModel(endPoint: APIConstant.kUpdateUserProfile,
                                          user_id: self.profileModel?.user_id,
                                          locality: self.profileModel?.locality,
                                          address: self.profileModel?.address,
                                          lat: "",
                                          long: "",
                                          contact_person_name: self.profileModel?.contact_person_name,
                                          company_name: self.profileModel?.company_name,
                                          price: self.profileModel?.price,
                                          business_description: self.profileModel?.business_description,
                                          operating_since: self.profileModel?.operating_since,
                                          transaction_type: self.profileModel?.transaction_type,
                                          type_of_property: self.profileModel?.type_of_property,
                                          portfolio: self.profileModel?.portfolio)
        
        
        AgentProfileViewModel.shared().updateProfile(paramApi: params) { [weak self](success, msg) in
            guard let self = self else { return }
            
            if success{
                UtilityMangr.shared.showAlertWithCompletion(title: "", msg: msg, vwController: self) {
                    self.push(AgentTabbarVC.getVC(.AgentTabbar))
                }
            }else{
                UtilityMangr.shared.showAlert(title: "", msg: msg, vwController: self)
            }
        }
        
    }
    
}
