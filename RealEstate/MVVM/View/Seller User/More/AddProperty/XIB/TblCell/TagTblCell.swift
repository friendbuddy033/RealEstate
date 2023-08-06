//
//  TagTblCell.swift
//  RealEstate
//
//  Created by Surinder kumar on 25/06/23.
//

import UIKit
import TagListView

protocol TagTableDelegates{
    func didSelectTag(section: Int,tag: String)
}

class TagTblCell: UITableViewCell {

    @IBOutlet weak var vwTag: TagListView!
    
    var delegate: TagTableDelegates?
    var section : Int = 0
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        vwTag.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
extension TagTblCell:  TagListViewDelegate{
    
    func tagPressed(_ title: String, tagView: TagView, sender: TagListView) {
        sender.tagViews.forEach {$0.isSelected = false}
        tagView.isSelected = !tagView.isSelected
        self.delegate?.didSelectTag(section: self.section, tag: title)
        
    }
    
}
