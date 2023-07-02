//
//  AgentDashboardVC.swift
//  RealEstate
//
//  Created by jass Dhariwal on 29/06/23.
//

import UIKit

class AgentDashboardVC: UIViewController {

    @IBOutlet weak var tblVwUsers: UITableView!{
        didSet{
            tblVwUsers.registerNib(cell: EnquiriesTblCell.self)
            tblVwUsers.registerNib(cell: AgentTblCell.self)
            tblVwUsers.delegate = self
            tblVwUsers.dataSource = self
        }
    }
    
    private enum headerSection : String,CaseIterable{
        case Enquiries = "Enquiries"
        case Popular = "Popular"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}
extension AgentDashboardVC: UITableViewDelegate, UITableViewDataSource
{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return headerSection.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch headerSection.allCases[indexPath.section]{
        case .Enquiries:
            let cell = tableView.dequeueReusableCell(withIdentifier: "EnquiriesTblCell", for: indexPath) as! EnquiriesTblCell
            cell.delegate = self
            return cell
        case .Popular:
            let cell = tableView.dequeueReusableCell(withIdentifier: "AgentTblCell", for: indexPath) as! AgentTblCell
            cell.cellType = .Property
            cell.constraintHeightClcVw.constant = 270
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let vw = HeaderView.instance
        vw.lblTitle.text = headerSection.allCases[section].rawValue
        vw.btnSeeMore.isHidden = headerSection.allCases[section].rawValue == headerSection.Enquiries.rawValue
//        vw.btnSeeMoreAction(<#T##sender: Any##Any#>)
        
        return vw
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    
    
}

//MARK: - PROTOCOL
extension AgentDashboardVC : realEstateDelegate{
    
    func enquiryTblVwReload() {
        self.tblVwUsers.reloadData()
    }
    
    func didSelect(indexPath: IndexPath) {
        self.push(AgentProfileVC.getVC(.Agent))
    }
    
}
