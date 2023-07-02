//
//  RealEstateProtocol.swift
//  RealEstate
//
//  Created by Surinder kumar on 24/06/23.
//

import Foundation

@objc protocol realEstateDelegate{
    @objc optional func enquiryTblVwReload()
    @objc optional func didSelect(indexPath: IndexPath)
}
