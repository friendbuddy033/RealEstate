//
//  AgentProfileVC.swift
//  RealEstate
//
//  Created by jass Dhariwal on 01/07/23.
//

import UIKit

class AgentProfileVC: UIViewController {

    @IBOutlet weak var viewBack: UIView!
    @IBOutlet weak var tblVw: UITableView!{
        didSet{
            tblVw.registerNib(cell: HistoryTblCell.self)
            tblVw.delegate = self
            tblVw.dataSource = self
        }
    }
    
    var isOtherPerson: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        viewBack.isHidden = !isOtherPerson
    }
    

    @IBAction func btnBackAction(_ sender: Any)
    {
        self.popVc()
    }

}
extension AgentProfileVC: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HistoryTblCell.identifier, for: indexPath) as! HistoryTblCell
        
        cell.selectionStyle = .none
        cell.cellType = .profile
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 185
    }
    
}
