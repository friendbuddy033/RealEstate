//
//  CommonModel.swift
//  RealEstate
//
//  Created by Surinder kumar on 29/06/23.
//

import Foundation

import UIKit

struct CommonModel<T: Codable> : Codable
{
    var data: T?
    var message: String?
    var statusCode: Int?
}

struct EmptyModel: Codable { }
