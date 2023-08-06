//
//  PropertiesTblCell.swift
//  RealEstate
//
//  Created by Surinder kumar on 23/06/23.
//

import UIKit

class PropertiesTblCell: UITableViewCell {

    
    @IBOutlet weak var imgProperty: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblLocation: UILabel!
    @IBOutlet weak var lblStatus: UILabel!
    @IBOutlet weak var lblAmount: UILabel!
    
    public enum CellType: String
    {
        case normal
        case history
    }
    
    var type: CellType = .normal{
        didSet{
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func btnEditAction(_ sender: Any) {
        
    }
}
