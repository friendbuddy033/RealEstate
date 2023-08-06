//
//  AddPropertyVC.swift
//  RealEstate
//
//  Created by Surinder kumar on 25/06/23.
//

import UIKit

class AddPropertyVC: UIViewController {

    @IBOutlet weak var tblVw: UITableView!{
        didSet{
            tblVw.delegate = self
            tblVw.dataSource = self
            tblVw.registerNib(cell: TagTblCell.self)
        }
    }
    
    private enum headerTiles : String,CaseIterable{
        case DoyouWant = "Do you  want to"
        case PropertyType = "Property Type"
        case BHK = "BHK"
        case Bathroom = "Bathroom"
        case Balcony = "Balcony"
        case AdditionalRoom = "Additional Room"
    }
    
    var propertyArray : [AddPropertyModel]?
    var isFromUpdate: Bool = false
    private var propertyParams: PropertyParamModel?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    @IBAction func btnNextAction(_ sender: Any) {
        self.pushToAddPropertyNext()
    }
    
}

//MARK: SETUI
extension AddPropertyVC{
    
    func setUI(){
        let DoyouWant = AddPropertyModel(headerTitle: headerTiles.DoyouWant.rawValue,features: ["Sell","Rent Out"])
        let propertType = AddPropertyModel(headerTitle: headerTiles.PropertyType.rawValue,features: ["Flat","Villa","Plot","Apartment"])
        let bhk = AddPropertyModel(headerTitle: headerTiles.BHK.rawValue,features: ["1BHK","2BHK","3BHK","4BHK","5BHK"])
        let Bathroom = AddPropertyModel(headerTitle: headerTiles.Bathroom.rawValue,features: ["1","2","3","4","5+"])
        let Balcony = AddPropertyModel(headerTitle: headerTiles.Balcony.rawValue,features: ["0","1","2","3+"])
        let propertType1 = AddPropertyModel(headerTitle: headerTiles.PropertyType.rawValue,features: ["Furnished","Semi-Furnished"])
        let AdditionalRoom = AddPropertyModel(headerTitle: headerTiles.AdditionalRoom.rawValue,features: ["Pooja Room","Study","Store","Servent Room"])
        
        propertyArray = [DoyouWant,propertType,bhk,Bathroom,Balcony,propertType1,AdditionalRoom]
        self.propertyParams = PropertyParamModel(endPoint: APIConstant.kAddProperty)
    }
    
}


//MARK: - TABLEVIEW DELEGATE AND DATASOURCE
extension AddPropertyVC:UITableViewDelegate,UITableViewDataSource{
    
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
        cell.vwTag.addTags(propertyArray?[indexPath.section].features ?? [])
        cell.delegate = self
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
extension AddPropertyVC : TagTableDelegates{
    func didSelectTag(section: Int, tag: String) {
        
        let features = propertyArray?[section].features ?? []
        
        if let selectedfeature = features.firstIndex(where: {$0 == tag})
        {
            switch section{

            case 0 : self.propertyParams?.do_you_want_to = features[selectedfeature]
            case 1 : self.propertyParams?.propert_type = features[selectedfeature]
            case 2 : self.propertyParams?.bhk = features[selectedfeature]
            case 3 : self.propertyParams?.bathrooms = features[selectedfeature]
            case 4 : self.propertyParams?.balcony = features[selectedfeature]
            case 5 : self.propertyParams?.property_furnished = features[selectedfeature]
            case 6 : self.propertyParams?.additional_rooms = features[selectedfeature]

            default : break
            }
        }
        
        Logger.log(self.propertyParams!)
        
        
    }
    
    

}
//MARK: NAVIGATION
extension AddPropertyVC{
    
    func pushToAddPropertyNext(){
        let vc = AddPropertyNextVC.getVC(.More)
        vc.propertyParams = self.propertyParams
        self.push(vc)
    }
    
}
