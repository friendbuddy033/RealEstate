//
//  APIConstant.swift
//  CampersCloset
//
//  Created by Surinder Kumar on 16/05/22.
//

import Foundation


struct APIConstant {
    //MARK: Local Server
    static let kUrl = "https://theofficepoint.co.in/realestate/app-api-processing"
    
    //MARK: COMPLETE BASEURL
    static let kBaseUrl = kUrl
    
    //MARK: ENDPOINT
    static let kRegister            = "register"
    static let kVerifyCode          = "verifyCode"
    static let kLogin               = "login"
    static let kUpdateUserProfile   = "updateUserDetails"
    static let kGetUsersByRole      = "getAllUsersByRole"
    static let kGetProperties       = "getAllPropertiesForUser"
    static let kAddProperty         = "addProperty"
    static let kUpdateProperty      = "updateProperty"
    static let kGetUserDetailsById  = "getUserFullDetailsByID"
    
    
}
