//
//  PropertyViewModel.swift
//  RealEstate
//
//  Created by Ajay Rajput on 04/08/23.
//

import UIKit

class PropertyViewModel: NSObject{
    
    private static var privateShared : PropertyViewModel?
    
    class func shared() -> PropertyViewModel { // change class to final to prevent override
        guard let uwShared = privateShared else {
            privateShared = PropertyViewModel()
            return privateShared!
        }
        return uwShared
    }
    
    class func destroy() {privateShared = nil}
    private override init() {print("init singleton")}
    deinit {print("deinit singleton")}
}
extension PropertyViewModel{
    
    
    func addNewProperty(paramApi: PropertyParamModel,completion:@escaping completionHandler)
    {
        server(url: APIConstant.kBaseUrl , apiMethod: .post, header: nil, isLoaderShow: true, paramApiModel: paramApi) { [weak self] (responseDict,responseData,success) in

            print("response: ",responseDict)

            let usersData = try? JSONDecoder().decode(CommonModel<EmptyModel>.self, from: responseData ?? Data())
            /*
             {"statusCode": 200, "data": {
                 "property_id" = 159;
             }, "message": Property Successfully Added.}
             */
            print("decoded response: ",usersData?.data?.dictionary ?? [:])
                        
            if usersData?.statusCode == 200 {
                completion(true,usersData?.message ?? "")
            }else{
                completion(false,usersData?.message ?? "")
            }
            
        }
        
    }
    
    func getAllProperties(completion:@escaping completionHandler)
    {
        let params = PropertyParamModel(user_id: UtilityMangr.shared.getUserDetail()?.userID, endPoint: APIConstant.kGetProperties)
        
        server(url: APIConstant.kBaseUrl , apiMethod: .post, header: nil, isLoaderShow: true, paramApiModel: params) { [weak self] (responseDict,responseData,success) in

            print("response: ",responseDict)

            let usersData = try? JSONDecoder().decode(CommonModel<EmptyModel>.self, from: responseData ?? Data())
            
            print("decoded response: ",usersData?.data?.dictionary ?? [:])
                        
            if usersData?.statusCode == 200 {
                completion(true,usersData?.message ?? "")
            }else{
                completion(false,usersData?.message ?? "")
            }
            
        }
    }
    
}
