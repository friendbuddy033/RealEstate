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
    
    
    func loginAPI(paramApi:AuthParamApiModel,completion:@escaping completionHandler){
        server(url: APIConstant.kBaseUrl , apiMethod: .post, header: nil, isLoaderShow: true, paramApiModel: paramApi) { [weak self] (responseDict,responseData,success) in

            let usersData = try? JSONDecoder().decode(CommonModel<LoginModel>.self, from: responseData ?? Data())
            
            print("login response: ",usersData?.data?.dictionary ?? [:])
            
//            UserDefaults.standard.
            
            if usersData?.statusCode == 200 {
                completion(true,usersData?.message ?? "")
            }else{
                completion(false,usersData?.message ?? "")
            }
            
        }
    }
    
    func registerAPI(paramApi:AuthParamApiModel,completion:@escaping completionHandler){
        server(url: APIConstant.kBaseUrl , apiMethod: .post, header: nil, isLoaderShow: true, paramApiModel: paramApi) { [weak self] (responseDict,responseData,success) in

            let usersData = try? JSONDecoder().decode(RegisterModel.self, from: responseData ?? Data())
            if usersData?.statusCode == 200 {
                completion(true,usersData?.message ?? "")
            }else{
                completion(false,usersData?.message ?? "")
            }
            
        }
    }
    
    func verifyOtpAPI(paramApi:AuthParamApiModel,completion:@escaping completionHandlerPage){
        server(url: APIConstant.kBaseUrl , apiMethod: .post, header: nil, isLoaderShow: true, paramApiModel: paramApi) { [weak self] (responseDict,responseData,success) in

            let usersData = try? JSONDecoder().decode(RegisterModel.self, from: responseData ?? Data())
            if usersData?.statusCode == 200 {
                completion(true,usersData?.message ?? "",usersData?.userID ?? 0)
            }else{
                completion(false,usersData?.message ?? "",0)
            }
            
        }
    }
    
}
