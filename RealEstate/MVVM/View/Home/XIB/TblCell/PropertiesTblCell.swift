//
//  PropertiesTblCell.swift
//  RealEstate
//
//  Created by Surinder kumar on 23/06/23.
//

import UIKit

class PropertiesTblCell: UITableViewCell {

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
    
}
