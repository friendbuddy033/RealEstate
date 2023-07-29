//
//  AgentProfileViewModel.swift
//  RealEstate
//
//  Created by Apple on 28/07/23.
//

import UIKit

class AgentProfileViewModel: NSObject{
    
    private static var privateShared : AgentProfileViewModel?
    
    class func shared() -> AgentProfileViewModel { // change class to final to prevent override
        guard let uwShared = privateShared else {
            privateShared = AgentProfileViewModel()
            return privateShared!
        }
        return uwShared
    }
    
    class func destroy() {privateShared = nil}
    private override init() {print("init singleton")}
    deinit {print("deinit singleton")}
}
extension AgentProfileViewModel{
    
    
    func updateProfile(paramApi: ProfileParamApiModel,completion:@escaping completionHandler)
    {
        server(url: APIConstant.kBaseUrl , apiMethod: .post, header: nil, isLoaderShow: true, paramApiModel: paramApi) { [weak self] (responseDict,responseData,success) in

            let usersData = try? JSONDecoder().decode(CommonModel<EmptyModel>.self, from: responseData ?? Data())
            
            print("login response: ",usersData?.data?.dictionary ?? [:])
                        
            if usersData?.statusCode == 200 {
                completion(true,usersData?.message ?? "")
            }else{
                completion(false,usersData?.message ?? "")
            }
            
        }
        
    }
    
}
