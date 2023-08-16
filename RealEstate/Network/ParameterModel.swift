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
    var userID: Int?

}

struct ProfileParamApiModel: CommonAPIModel
{
    var endPoint: String?
    var role: String?
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
 
struct PropertyParamModel: CommonAPIModel
{
    var user_id: Int?
    var property_id: Int?
    var endPoint: String?
    var cc: String?
    var propert_type: String?
    var do_you_want_to: String?
    var bathrooms: String?
    var bhk: String?
    var balcony: String?
    var property_furnished: String?
    var additional_rooms: String?
    var transaction_type: String?
    var overlooking: String?
    var availability_status: String?
    var location: String?
    var lat: String?
    var long: String?
    var total_flats: String?
    var directional_facing: String?
    var money: String?
    var gallery: [Data]?
}
