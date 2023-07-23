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
    
    var propertyArray : [AddPropertyModel]?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.setUI()
    }
    

    @IBAction func btnSaveAtion(_ sender: UIButton){
        self.push(AgentTabbarVC.getVC(.AgentTabbar))
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
extension AgentRegistStepTwoVC:UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return propertyArray?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TagTblCell", for: indexPath) as! TagTblCell
        cell.vwTag.addTags(propertyArray?[indexPath.section].features ?? [])
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
    
}
