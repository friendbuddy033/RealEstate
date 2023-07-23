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

//MARK: API
extension UserViewModel{
    
    func registerAPI(paramApi:ParamApiModel,completion:@escaping completionHandler){
        server(url: APIConstant.kBaseUrl , apiMethod: .post, header: nil, isLoaderShow: true, paramApiModel: paramApi) { [weak self] (responseDict,responseData,success) in

            let usersData = try? JSONDecoder().decode(RegisterModel.self, from: responseData ?? Data())
            if usersData?.statusCode == 200 {
                completion(true,usersData?.message ?? "")
            }else{
                completion(false,usersData?.message ?? "")
            }
            
        }
    }
    
    func verifyOtpAPI(paramApi:ParamApiModel,completion:@escaping completionHandler){
        server(url: APIConstant.kBaseUrl , apiMethod: .post, header: nil, isLoaderShow: true, paramApiModel: paramApi) { [weak self] (responseDict,responseData,success) in

            let usersData = try? JSONDecoder().decode(RegisterModel.self, from: responseData ?? Data())
            if usersData?.statusCode == 200 {
                completion(true,usersData?.message ?? "")
            }else{
                completion(false,usersData?.message ?? "")
            }
            
        }
    }
    
}
