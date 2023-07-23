//
//  DropDownVC.swift
//  RealEstate
//
//  Created by Surinder kumar on 23/07/23.
//

import UIKit

class DropDownVC: UIViewController {

    @IBOutlet weak var tblVw: UITableView!{
        didSet{
            tblVw.delegate = self
            tblVw.dataSource = self
            tblVw.registerNib(cell: DropDownTblCell.self)
        }
    }
    var managerFilter : [DropDownModel]?
    
    public var comingFrom : ScreenName = .loginType
    public var selectedType : ((String,String,Int)->Void)?
    public var selectedIndex : Int = -1
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        managerDropdown()
    }
    

}

//MARK: SETUI
extension DropDownVC{
    
    func managerDropdown(){
        switch comingFrom{
        case .loginType:
            managerFilter = [DropDownModel(title: "User",keyValue: ""),DropDownModel(title: "Agent",keyValue: "property_agent")]
        default:
            Logger.log("default")
        }
        self.tblVw.reloadData()
    }
    
}


//MARK: TABLEVIEW DELEGATE AND DATASOURCE
extension DropDownVC:UITableViewDelegate,UITableViewDataSource{

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return managerFilter?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DropDownTblCell", for: indexPath) as! DropDownTblCell
        cell.imgRadio.image = selectedIndex == indexPath.row ? UIImage(named: "radioIcon") : nil
        cell.lblTitle.text = managerFilter?[indexPath.row].title ?? ""
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedType?(managerFilter?[indexPath.row].title ?? "",managerFilter?[indexPath.row].keyValue ?? "",indexPath.row)
        self.dismiss(animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }

}
