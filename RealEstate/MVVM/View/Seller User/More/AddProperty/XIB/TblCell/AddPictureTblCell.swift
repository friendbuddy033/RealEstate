//
//  AddPictureTblCell.swift
//  RealEstate
//
//  Created by Surinder kumar on 02/07/23.
//

import UIKit

class AddPictureTblCell: UITableViewCell {
    @IBOutlet weak var imgCamera: UIImageView!
    @IBOutlet weak var lblPlaceholder: UILabel!
    
    @IBOutlet weak var imgSelected: UIImageView!
    @IBOutlet weak var vwImg: ViewCustom!
    @IBOutlet weak var vwAddImg: ViewCustom!
    @IBOutlet weak var imageCamera: UIImageView!
    @IBOutlet weak var vwEdit: ViewCustom!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
