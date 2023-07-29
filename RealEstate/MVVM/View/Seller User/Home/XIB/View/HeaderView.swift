//
//  HeaderView.swift
//  RealEstate
//
//  Created by Surinder kumar on 23/06/23.
//

import UIKit

class HeaderView: UIView {

    @IBOutlet weak var btnSeeMore: UIButton!
    @IBOutlet weak var lblTitle: UILabel!
    static var share: HeaderView? = nil
    
    static var instance: HeaderView {
        
        //if (share == nil) {
            share = Bundle(for: self).loadNibNamed("HeaderView",
                                                   owner: nil,
                                                   options: nil)?.first as? HeaderView
       // }
        return share!
    }

    @IBAction func btnSeeMoreAction(_ sender: Any) {
    }
}
