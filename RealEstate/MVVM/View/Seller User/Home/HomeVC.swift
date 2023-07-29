//
//  HomeVC.swift
//  RealEstate
//
//  Created by Surinder kumar on 23/06/23.
//

import UIKit

class HomeVC: UIViewController {

    @IBOutlet weak var tblVw: UITableView!{
        didSet{
            tblVw.delegate = self
            tblVw.dataSource = self
            tblVw.registerNib(cell: PropertiesTblCell.self)
            tblVw.registerNib(cell: EnquiriesTblCell.self)
            tblVw.registerNib(cell: AgentTblCell.self)
        }
    }
    
    private enum headerSection : String,CaseIterable{
        case Properties = "My  Properties"
        case Enquiries = "Enquiries"
        case HireAgent = "My Hire Agents"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
}

//MARK: - TABLEVIEW DELEGATE AND DATASOURCE
extension HomeVC:UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return headerSection.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch headerSection.allCases[indexPath.section]{
        case .Properties:
            let cell = tableView.dequeueReusableCell(withIdentifier: "PropertiesTblCell", for: indexPath) as! PropertiesTblCell
            return cell
        case .Enquiries:
            let cell = tableView.dequeueReusableCell(withIdentifier: "EnquiriesTblCell", for: indexPath) as! EnquiriesTblCell
            cell.delegate = self
            return cell
        case .HireAgent:
            let cell = tableView.dequeueReusableCell(withIdentifier: "AgentTblCell", for: indexPath) as! AgentTblCell
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let vw = HeaderView.instance
        vw.lblTitle.text = headerSection.allCases[section].rawValue
        vw.btnSeeMore.isHidden = headerSection.allCases[section].rawValue == headerSection.HireAgent.rawValue ? false : true
        return vw
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    
    
}

//MARK: - PROTOCOL
extension HomeVC : realEstateDelegate{
    
    func enquiryTblVwReload() {
        self.tblVw.reloadData()
    }
    
    func didSelect(indexPath: IndexPath) {
//        self.push()
    }
    
}
