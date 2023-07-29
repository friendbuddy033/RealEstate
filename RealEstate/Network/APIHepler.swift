//
//  APIHepler.swift
//  ProductForm
//
//  Created by Surinder Kumar on 01/08/21.
//

import Foundation
import Alamofire
import NVActivityIndicatorView
import UIKit

func server(url:String,apiMethod:HTTPMethod,header:HTTPHeaders?,isLoaderShow:Bool,loaderColor:UIColor = .white,paramApiModel:CommonAPIModel,param:[String:Any]?=nil,completion:@escaping([String:Any],Data?,Bool)->()){
    //    let activity = NVActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 30, height: 30), type: .lineScale, color: .white, padding: nil)
    //    activity.startAnimating()
    
    print("baseurl:-",url)
    print("parameter:-",paramApiModel.dictionary ?? [:])
    if Connectivity.isConnectedToInternet(){
        if isLoaderShow{
            Indicator.shared.start("",loaderColor: loaderColor)
            
        }
        
        let params = param == nil ? paramApiModel.dictionary ?? [:] : param
        //let params = param
        
        print("parameter:-",params as? NSDictionary)
        var allHeaders = UtilityMangr.shared.getHeaderToken()
        header?.forEach({ allHeaders.add($0) })
        Logger.log("header:-\(allHeaders)")
        
        AF.request(url, method: apiMethod, parameters: params,encoding: JSONEncoding.default ,headers: allHeaders).responseJSON { (response) in
            if isLoaderShow{
                Indicator.shared.stop()
                
            }
            //   activity.stopAnimating()
            
            if let data = response.data, let str = String(data: data, encoding: .utf8){
                //print("server error:-",str)
                Logger.log("server error:- \(str)")
            }
            
            //print("response.response?.statusCode:-",response.result)
            switch (response.result){
            
            case .success(_):
                
                if let dict = response.value as? [String:Any]{
                    
                    Logger.log("ResponseData:- \(dict)")
                    
                    if response.response?.statusCode == 401{
                        
                        UtilityMangr.shared.showAlertWithCompletion(title: "", msg: "Session Expired", vwController: UIApplication.topViewController() ?? UIViewController()) {
                          //  UtilityManager.shared.removeDetailsLogout()
                            let story = UIStoryboard(name: "Main", bundle:nil)
                            let vc = story.instantiateViewController(withIdentifier: "LoginVC")
                            let navigationController = UINavigationController(rootViewController: vc)
                            //navigationController.navigationBar.isHidden = true
                            navigationController.setNavigationBarHidden(true, animated: false)
                            UIApplication.shared.windows.first?.rootViewController = navigationController
                            UIApplication.shared.windows.first?.makeKeyAndVisible()
                        }
                        
                        
                    }else{
                        completion(dict,response.data, true)
                    }
                }
                break
            case .failure(let error):
                let dict = ["status_code":500,"message":error.localizedDescription ] as [String : Any]
                let jsonData = dict.jsonStringRepresentation?.data(using: .utf8) ?? Data()
                completion([:],jsonData,false)
                break
            }
        }
    }else{
        let dict = ["status_code":501,"message":"Please connect to the internet"] as [String : Any]
        let jsonData = dict.jsonStringRepresentation?.data(using: .utf8) ?? Data()
        completion(dict,jsonData, false)
    }
    
    
}


func uploadDataToServer(url:String,imageKey:String,imagedata:Data?,param:[String:String],loaderColor:UIColor = .white,paramApiModel:AuthParamApiModel,completion:@escaping([String:Any],Data?)->()){
    if Connectivity.isConnectedToInternet(){
        Indicator.shared.start("", loaderColor: loaderColor)
       // Indicator.shared.showHud()
        let params = paramApiModel.dictionary ?? [:]
        
        AF.upload(multipartFormData: { multipartFormData in
            for (key, value) in params {
                multipartFormData.append("\(value)".data(using: .utf8)!, withName: key)
            }
            
            if let dataarray = imagedata{
                
                // for (index,value) in dataarray.enumerated(){
                
                // print(value)
                multipartFormData.append(dataarray, withName: imageKey, fileName: "\(UUID().uuidString).png", mimeType: "\(UUID().uuidString)/png")
                //}
            }
        },
                  to: url, method: .post , headers: UtilityMangr.shared.getHeaderToken())
            .responseJSON(completionHandler: { (response) in
                Indicator.shared.stop()
               // Indicator.shared.stopHud()
                if let data = response.data, let str = String(data: data, encoding: .utf8){
                    Logger.log("server error:- \(str)")
                }
                // print("response.response?.statusCode:-",response.response?.statusCode)
                
                if let err = response.error{
                    print(err)
                    return
                }
                print("Succesfully uploaded")
                
                let json = response.value as? [String:Any] ?? [:]
                
                if (json != nil)
                {
                    completion(json, response.data)
                    // let jsonObject = JSON(json!)
                    // print(jsonObject)
                }
            })
    }else{
        let dict = ["status_code":501,"message":"Please connect to the internet"] as [String : Any]
        let jsonData = dict.jsonStringRepresentation?.data(using: .utf8) ?? Data()
        completion(dict, jsonData)
    }
}

