//
//  SavePropertyVC.swift
//  RealEstate
//
//  Created by Surinder kumar on 02/07/23.
//

import UIKit

class SavePropertyVC: UIViewController {

    @IBOutlet weak var tblVw: UITableView!{
        didSet{
            tblVw.delegate = self
            tblVw.dataSource = self
            tblVw.registerNib(cell: TextFieldTblCell.self)
            tblVw.registerNib(cell: AddPictureTblCell.self)
        }
    }
    
    private enum headerTiles : String,CaseIterable{
        case AddMoney = "Add Money"
        case AddPictureSelf = "Add Picture Self"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnBackAction(_ sender: Any) {
        self.popVc()
    }
    
    @IBAction func btnSaveAction(_ sender: Any) {
        self.pushToSuccess()
    }
    
    @IBAction func btnAddPictureProfessionalAction(_ sender: Any) {
        self.pushToPictureProfessional()
    }
    
}


//MARK: - TABLEVIEW DELEGATE AND DATASOURCE
extension SavePropertyVC:UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return headerTiles.allCases.count 
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch headerTiles.allCases[indexPath.section]{
        case .AddMoney:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TextFieldTblCell", for: indexPath) as! TextFieldTblCell
            return cell
        case .AddPictureSelf:
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddPictureTblCell", for: indexPath) as! AddPictureTblCell
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let vw = HeaderView.instance
        vw.lblTitle.text = headerTiles.allCases[section].rawValue
        vw.lblTitle.font = UIFont(name: FontName.semiBold, size: 18)
        vw.lblTitle.textColor = AppColor.themeColor
        vw.btnSeeMore.isHidden = true
        return vw
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 45
    }
    
}

//MARK: NAVIGATION
extension SavePropertyVC{
    
    func pushToSuccess(){
        let vc = PropertyAddedSuccessVC.getVC(.More)
        self.push(vc)
    }
    
    func pushToPictureProfessional(){
        let vc = ProfessionalPhotoVC.getVC(.More)
        self.push(vc)
    }
    
}
