//
//  FilterTypeCell.swift
//  RealEstate
//
//  Created by jass Dhariwal on 24/06/23.
//

import UIKit

class FilterTypeCell: UITableViewCell {

    @IBOutlet weak var imageSelectedBar: UIImageView!
    @IBOutlet weak var labelCategoryName: UILabel!
    
    var isSelectedCategory: Bool = false{
        didSet{
            imageSelectedBar.isHidden = !isSelectedCategory
            labelCategoryName.font = isSelectedCategory ? .joshMedium(size: 20) : .joshRegular(size: 16)
            labelCategoryName.textColor = isSelectedCategory ? .btnThemeColor : .blackColor
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
