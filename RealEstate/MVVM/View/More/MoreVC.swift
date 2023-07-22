//
//  MoreVC.swift
//  RealEstate
//
//  Created by Surinder kumar on 25/06/23.
//

import UIKit

class MoreVC: UIViewController {

    @IBOutlet weak var tblVw: UITableView!{
        didSet{
            tblVw.delegate = self
            tblVw.dataSource = self
            tblVw.registerNib(cell: MoreTblCell.self)
        }
    }
    
    private enum moreTiles : String,CaseIterable{
        case Profile  = "Profile"
        case Chat = "Chat"
        case Settings = "Settings"
        case AboutUs  = "About Us"
        case PrivacyPolicy = "Privacy Policy"
        case HelpSupport = "Help & Support"
        case TermsConditions = "Terms & Conditions"
        case Logout = "Logout"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    

}


//MARK: - TABLEVIEW DELEGATE AND DATASOURCE
extension MoreVC:UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moreTiles.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MoreTblCell", for: indexPath) as! MoreTblCell
        cell.lblTiles.text = moreTiles.allCases[indexPath.row].rawValue
        cell.lblTiles.textColor = moreTiles.allCases[indexPath.row].rawValue == moreTiles.Logout.rawValue ? AppColor.logoutColor : .black.withAlphaComponent(0.8)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = AddPropertyVC.getVC(.More)
        self.push(vc)
    }
    
}
