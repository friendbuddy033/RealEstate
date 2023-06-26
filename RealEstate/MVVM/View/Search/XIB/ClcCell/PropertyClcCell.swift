//
//  PropertyClcCell.swift
//  RealEstate
//
//  Created by Surinder kumar on 24/06/23.
//

import UIKit

class PropertyClcCell: UICollectionViewCell {

    enum PropertyCellTypes: Int{
        case small = 0
        case regular
    }
    
    @IBOutlet weak var frameImageHeight: NSLayoutConstraint!
    
    var cellType: PropertyCellTypes = .regular{
        didSet{
            self.configureUI()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    private func configureUI()
    {
        switch cellType{
        case .regular :
            frameImageHeight.constant = 170
        case .small :
            frameImageHeight.constant = 136
        }
    }

}
