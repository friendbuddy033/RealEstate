//
//  EnquiriesTblCell.swift
//  RealEstate
//
//  Created by Surinder kumar on 23/06/23.
//

import UIKit

class EnquiriesTblCell: UITableViewCell {

    @IBOutlet weak var tblVw: UITableView!{
        didSet{
            tblVw.delegate = self
            tblVw.dataSource = self
            tblVw.registerNib(cell: EnquryDetailTblCell.self)
        }
    }
    @IBOutlet weak var constraintHeightTblVw: NSLayoutConstraint!
    
    public weak var delegate : realEstateDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        tblVw.reloadData()
        constraintHeightTblVw.constant = 1
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

//MARK: - TABLEVIEW DELEGATE AND DATASOURCE
extension EnquiriesTblCell : UITableViewDelegate,UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EnquryDetailTblCell", for: indexPath) as! EnquryDetailTblCell
        constraintHeightTblVw.constant = tblVw.contentSize.height + 40
        //if delegate == nil{
            delegate?.enquiryTblVwReload?()
        //}
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.didSelect?(indexPath: indexPath)
    }
}
