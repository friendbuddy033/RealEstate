//
//  HistoryTblCell.swift
//  RealEstate
//
//  Created by jass Dhariwal on 01/07/23.
//

import UIKit

class HistoryTblCell: UITableViewCell {

    @IBOutlet weak var imageHeightConstant: NSLayoutConstraint!
    @IBOutlet weak var buttonViewMore: UIButton!
    @IBOutlet weak var labelPrice: UILabel!
    @IBOutlet weak var labelDate: UILabel!
    @IBOutlet weak var viewUserProfile: ViewCustom!
    
    public enum CellType: String{
        case history
        case profile
    }
    
    var cellType: CellType = .history{
        didSet{
            self.configureUI()
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
    
    func configureUI()
    {
        switch self.cellType
        {
        case .history:
            imageHeightConstant.constant = 130
            buttonViewMore.isHidden = false
            labelPrice.isHidden = false
            labelDate.isHidden = false
            viewUserProfile.isHidden = true
        case .profile:
            imageHeightConstant.constant = 120
            buttonViewMore.isHidden = true
            labelPrice.isHidden = true
            labelDate.isHidden = true
            viewUserProfile.isHidden = false
        }
    }
    
}
