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
    var propertyParams: PropertyParamModel?

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
        cell.vwTag.removeAllTags()
        cell.section = indexPath.section
        cell.delegate = self
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
        
        DispatchQueue.main.async {
            [
                vw.tfLocation,
                vw.tfTotalNumber,
                vw.tfDirectionalface
            ].forEach({$0?.addTarget(self, action: #selector(self.handleFooterTextfield(_ :)), for: .editingChanged)})
        }
        
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
extension AddPropertyNextVC : TagTableDelegates{
    func didSelectTag(section: Int, tag: String) {
        
        let features = propertyArray?[section].features ?? []
        
        if let selectedfeature = features.firstIndex(where: {$0 == tag})
        {
            switch section{

            case 0 : self.propertyParams?.transaction_type = features[selectedfeature]
            case 1 : self.propertyParams?.overlooking = features[selectedfeature]
            case 2 : self.propertyParams?.availability_status = features[selectedfeature]

            default : break
            }
        }
        
        Logger.log(self.propertyParams!)
        
        
    }
    
    

}
//MARK: NAVIGATION
extension AddPropertyNextVC{
    
    @objc private func handleFooterTextfield(_ txtfield: UITextField){
        let fieldIndex = txtfield.tag
        switch fieldIndex
        {
            
        case 0: self.propertyParams?.location = txtfield.text
        case 1: self.propertyParams?.total_flats = txtfield.text
        case 2: self.propertyParams?.directional_facing = txtfield.text
            
        default : break
            
        }
        
    }
    
    private func pushToSaveProperty(){
        let vc = SavePropertyVC.getVC(.More)
        vc.propertyParams = self.propertyParams
        self.push(vc)
    }
    
}
