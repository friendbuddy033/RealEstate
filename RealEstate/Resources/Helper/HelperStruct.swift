//
//  HelperStruct.swift
//  RealEstate
//
//  Created by Surinder kumar on 25/06/23.
//

import Foundation


struct AddPropertyModel : Codable{
    var headerTitle : String?
    var features : [String]?
}

struct DropDownModel : Codable{
    var id : Int?
    var title : String?
    var keyValue : String?
}
