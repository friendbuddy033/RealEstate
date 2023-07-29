//
//  ParameterModel.swift
//  Mee
//
//  Created by Surinder kumar on 03/01/23.
//

import Foundation

protocol CommonAPIModel: Codable { }

struct AuthParamApiModel : CommonAPIModel
{
    var endPoint : String?
    var email : String?
    var full_name : String?
    var phone : String?
    var password : String?
    var type : String?
    var userType : String?
    var code : String?
    var device_id: String?
    var device_token: String?
    var device_type: String?
}

struct ProfileParamApiModel: CommonAPIModel
{
    var endPoint: String?
    var user_id: Int?
    var email: String?
    var full_name: String?
    var locality: String?
    var address: String?
    var lat: String?
    var long: String?
    var contact_person_name: String?
    var company_name: String?
    var price: String?
    var business_description: String?
    var operating_since: String?
    var transaction_type: String?
    var type_of_property: String?
    var portfolio: String?
}
