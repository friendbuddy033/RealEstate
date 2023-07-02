//
//  AddPropertyNextVC.swift
//  RealEstate
//
//  Created by Surinder kumar on 01/07/23.
//

import UIKit

class AddPropertyNextVC: UIViewController {

    @IBOutlet weak var tblVw: UITableView!{
        didSet{
            tblVw.delegate = self
            tblVw.dataSource = self
            tblVw.registerNib(cell: TagTblCell.self)
        }
    }
    
    private enum headerTiles : String,CaseIterable{
        case TransactionType = "Transaction Type"
        case Overlooking = "Overlooking"
        case AvailabilityStatus = "Availability Status"
    }
    
    var propertyArray : [AddPropertyModel]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUI()
    }
    
    @IBAction func btnBackAction(_ sender: Any) {
        self.popVc()
    }
    
    @IBAction func btnNextAction(_ sender: Any) {
        pushToSaveProperty()
    }
    
}

//MARK: SETUI
extension AddPropertyNextVC{
    
    private func setUI(){
        let transactionType = AddPropertyModel(headerTitle: headerTiles.TransactionType.rawValue,features: ["Resale","New"])
        let overlooking = AddPropertyModel(headerTitle: headerTiles.Overlooking.rawValue,features: ["Main Road","Garden/Park","Pool"])
        let availabilityStatus = AddPropertyModel(headerTitle: headerTiles.AvailabilityStatus.rawValue,features: ["Under- Construction","Ready to Move"])
        
        propertyArray = [transactionType,overlooking,availabilityStatus]
    }
    
}

//MARK: - TABLEVIEW DELEGATE AND DATASOURCE
extension AddPropertyNextVC:UITableViewDelegate,UITableViewDataSource{
    
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
    
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard ((propertyArray?.count ?? 0) - 1) == section else {return nil}
        let vw = PropertyFooterView.instance
        return vw
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        guard ((propertyArray?.count ?? 0) - 1) == section else {return 0}
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 45
    }
    
}

//MARK: NAVIGATION
extension AddPropertyNextVC{
    
   private func pushToSaveProperty(){
        let vc = SavePropertyVC.getVC(.More)
        self.push(vc)
    }
    
}
