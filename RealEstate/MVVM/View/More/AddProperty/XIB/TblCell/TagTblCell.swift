//
//  TagTblCell.swift
//  RealEstate
//
//  Created by Surinder kumar on 25/06/23.
//

import UIKit
import TagListView

class TagTblCell: UITableViewCell {

    @IBOutlet weak var vwTag: TagListView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
