//
//  UserViewModel.swift
//  RealEstate
//
//  Created by Surinder kumar on 29/06/23.
//

import UIKit

class UserViewModel: NSObject {

    private static var privateShared : UserViewModel?
    
    class func shared() -> UserViewModel { // change class to final to prevent override
        guard let uwShared = privateShared else {
            privateShared = UserViewModel()
            return privateShared!
        }
        return uwShared
    }
    
    class func destroy() {privateShared = nil}
    private override init() {print("init singleton")}
    deinit {print("deinit singleton")}
}
