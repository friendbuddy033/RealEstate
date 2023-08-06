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
    
    var propertyParams: PropertyParamModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    
    @IBAction func btnBackAction(_ sender: Any) {
        self.popVc()
    }
    
    @IBAction func btnSaveAction(_ sender: Any) {
//        self.pushToSuccess()
        if propertyParams?.money == "" || propertyParams?.money == nil {
            UtilityMangr.shared.showAlert(title: AppConstant.kOops, msg: "Please enter amount of property", vwController: self)
        }else{
            if let propertyParams{
                self.saveProperty(params: propertyParams)
            }
        }
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
            cell.selectionStyle = .none
            
            cell.tfAmount.addTarget(self, action: #selector(handleMoneyField(_ :)), for: .editingChanged)
            
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
    
    @objc private func handleMoneyField(_ txtfield: UITextField){
        propertyParams?.money = txtfield.text
    }
    
    func pushToSuccess(){
        let vc = PropertyAddedSuccessVC.getVC(.More)
        self.push(vc)
    }
    
    func pushToPictureProfessional(){
        let vc = ProfessionalPhotoVC.getVC(.More)
        self.push(vc)
    }
    
}
extension SavePropertyVC
{
    private func saveProperty(params : PropertyParamModel)
    {
        PropertyViewModel.shared().addNewProperty(paramApi: params) { [weak self] (success, msg) in
            guard let self = self else { return }
            if success{
                DispatchQueue.main.async {
                    self.pushToSuccess()
                }
            }else{
                DispatchQueue.main.async {
                    UtilityMangr.shared.showAlert(title: AppConstant.kOops, msg: msg, vwController: self)
                }
            }
        }
    }
    
}
