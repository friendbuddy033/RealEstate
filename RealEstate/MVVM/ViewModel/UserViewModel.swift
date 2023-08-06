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
    
    
    func loginAPI(paramApi:AuthParamApiModel,completion:@escaping completionHandlerPage){
        server(url: APIConstant.kBaseUrl , apiMethod: .post, header: nil, isLoaderShow: true, paramApiModel: paramApi) { [weak self] (responseDict,responseData,success) in
            
            let usersData = try? JSONDecoder().decode(RegisterModel.self, from: responseData ?? Data())
            
            print("login response: ",usersData?.dictionary ?? [:])
            
            
            if usersData?.statusCode == 200 {
                completion(true,usersData?.message ?? "",usersData?.userID ?? 0)
            }else{
                completion(false,usersData?.message ?? "",0)
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

            if paramApi.type == APIConstant.kLogin{
                let usersData = try? JSONDecoder().decode(CommonModel<LoginModel>.self, from: responseData ?? Data())

                if let userdetails = usersData?.data {
                    UtilityMangr.shared.saveUserDetails(details: userdetails)
                }
                
                if usersData?.statusCode == 200 {
                    completion(true,usersData?.message ?? "",0)
                }else{
                    completion(false,usersData?.message ?? "",0)
                }

            }else{
                let usersData = try? JSONDecoder().decode(RegisterModel.self, from: responseData ?? Data())
                if usersData?.statusCode == 200 {
                    completion(true,usersData?.message ?? "",usersData?.userID ?? 0)
                }else{
                    completion(false,usersData?.message ?? "",0)
                }
            }
            
            
        }
    }
    
    func getUserDetails(completion:@escaping completionHandler) {
        
        let params = PropertyParamModel( user_id: UtilityMangr.shared.getUserDetail()?.userID,endPoint: APIConstant.kGetUserDetailsById)
        
        server(url: APIConstant.kBaseUrl , apiMethod: .post, header: nil, isLoaderShow: true, paramApiModel: params) { [weak self] (responseDict,responseData,success) in
            Logger.log("responseDict : \(responseDict)")
            let data = try? JSONDecoder().decode(CommonModel<EmptyModel>.self, from: responseData ?? Data())
            Logger.log("decoded : \(data?.dictionary)")
            if data?.statusCode == 200 {
                completion(true,data?.message ?? "")
            }else{
                completion(false,data?.message ?? "")
            }
        }
    }
    
    
    func getUsersByRole(role: String,completion:@escaping ([LoginModel]?,String) -> Void) {
        
        let params = ProfileParamApiModel(endPoint: APIConstant.kGetUserDetailsById,role: role)

        server(url: APIConstant.kBaseUrl , apiMethod: .post, header: nil, isLoaderShow: true, paramApiModel: params) { [weak self] (responseDict,responseData,success) in
            Logger.log("responseDict : \(responseDict)")
            let data = try? JSONDecoder().decode(CommonModel<[LoginModel]>.self, from: responseData ?? Data())
            Logger.log("decoded : \(data?.dictionary)")
            if data?.statusCode == 200 {
                completion(data?.data,data?.message ?? "")
            }else{
                completion([],data?.message ?? "")
            }
        }
    }
    
    
    func logout(){
        UtilityMangr.shared.removeDetailsLogout()
        UtilityMangr.shared.makeLoginRoot()
    }
    
}
