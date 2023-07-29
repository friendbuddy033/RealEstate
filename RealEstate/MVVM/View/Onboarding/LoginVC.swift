//
//  LoginVC.swift
//  RealEstate
//
//  Created by Apple on 25/07/23.
//

import UIKit

class LoginVC: UIViewController {

    @IBOutlet weak var tfPhoneNo: TextFieldCustom!
    @IBOutlet weak var vwBg: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        vwBg.roundCorners(with: [.layerMinXMinYCorner,.layerMaxXMinYCorner], radius: 45)
    }

    
    @IBAction func btnGetOtpAction(_ sender: Any) {
        if tfPhoneNo.text == ""{
            UtilityMangr.shared.showAlert(title: AppConstant.kOops, msg: AppConstant.kEmptyPhoneNo, vwController: self)
        }else{
            self.loginAPI()
        }
    }
}
extension LoginVC{
    
    func pushToVerifyOtp(objParm:AuthParamApiModel){
        let vc = VerifyOtpVC.getVC(.Main)
        vc.mobileNumber = "+91\(tfPhoneNo.text ?? "")"
        vc.verificationType = APIConstant.kLogin
        self.push(vc)
    }

    
}
//MARK: API
extension LoginVC{
    
    func loginAPI(){
        
        let param = AuthParamApiModel(endPoint: APIConstant.kLogin,
                                  phone: "+91\(tfPhoneNo.text ?? "")",
                                  device_id: UIDevice.current.identifierForVendor?.uuidString ?? "",
                                  device_token: "fsdsd655dfdfdf",
                                  device_type: "ios")
        /*
         
         */
        
        UserViewModel.shared().loginAPI(paramApi: param) { [weak self] (success,msg) in
            if success{
                UtilityMangr.shared.showAlertWithCompletion(title: "", msg: msg, vwController: self ?? UIViewController()) { [weak self] in
                    self?.pushToVerifyOtp(objParm:param)
                }
            }else{
                UtilityMangr.shared.showAlert(title: AppConstant.kError, msg: msg, vwController: self ?? UIViewController())
            }
        }
    }
    
}
