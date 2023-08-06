//
//  PropertyFooterView.swift
//  RealEstate
//
//  Created by Surinder kumar on 01/07/23.
//

import UIKit

class PropertyFooterView: UIView {

    @IBOutlet weak var tfLocation: TextFieldCustom!
    @IBOutlet weak var tfTotalNumber: TextFieldCustom!
    @IBOutlet weak var tfDirectionalface: TextFieldCustom!
    
    static var share: PropertyFooterView? = nil
    
    static var instance: PropertyFooterView {
        
        //if (share == nil) {
            share = Bundle(for: self).loadNibNamed("PropertyFooterView",
                                                   owner: nil,
                                                   options: nil)?.first as? PropertyFooterView
       // }
        return share!
    }
}
