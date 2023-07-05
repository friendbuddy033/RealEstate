//
//  HistoryVC.swift
//  RealEstate
//
//  Created by jass Dhariwal on 01/07/23.
//

import UIKit

class HistoryVC: UIViewController {

    @IBOutlet weak var tblVwHistory: UITableView!{
        didSet{
            tblVwHistory.registerNib(cell: HistoryTblCell.self)
            tblVwHistory.delegate = self
            tblVwHistory.dataSource = self
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    
    
}
extension HistoryVC: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HistoryTblCell.identifier, for: indexPath) as! HistoryTblCell
        
        cell.selectionStyle = .none
        cell.cellType = .history
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 220
    }
    
}
