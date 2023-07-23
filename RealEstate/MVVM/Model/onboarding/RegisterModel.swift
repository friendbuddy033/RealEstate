//
//  RegisterModel.swift
//  RealEstate
//
//  Created by Surinder kumar on 23/07/23.
//

import Foundation

struct RegisterModel : Codable {
    var oTP : Int?
    var statusCode : Int?
    var message : String?

    enum CodingKeys: String, CodingKey {

        case oTP = "OTP"
        case statusCode = "statusCode"
        case message = "message"
    }

    init(from decoder: Decoder) throws {
        do{
            let values = try decoder.container(keyedBy: CodingKeys.self)
            oTP = try values.decodeIfPresent(Int.self, forKey: .oTP)
            statusCode = try values.decodeIfPresent(Int.self, forKey: .statusCode)
            message = try values.decodeIfPresent(String.self, forKey: .message)
        }catch{
            Logger.log("misType error:- \(error)")
        }
    }

}
