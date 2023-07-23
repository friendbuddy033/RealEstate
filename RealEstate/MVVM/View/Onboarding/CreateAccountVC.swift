//
//  CreateAccountVC.swift
//  RealEstate
//
//  Created by Surinder kumar on 21/06/23.
//

import UIKit

class CreateAccountVC: UIViewController {

    @IBOutlet weak var tfType: TextFieldCustom!
    @IBOutlet weak var tfPhoneNo: TextFieldCustom!
    @IBOutlet weak var tfPassword: TextFieldCustom!
    @IBOutlet weak var tfEmail: TextFieldCustom!
    @IBOutlet weak var tfName: TextFieldCustom!
    @IBOutlet weak var vwBg: UIView!
    
    private var selectedIndex : Int = -1
    private var selectedKeyValue : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2.0){ [weak self] in
//            let vc = RealEstateTabbarVC.getVC(.Tabbbar)
//            self?.push(vc)
//            let vc = AgentRegistStepOneVC.getVC(.Agent)
        }
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        vwBg.roundCorners(with: [.layerMinXMinYCorner,.layerMaxXMinYCorner], radius: 45)
    }
    
    @IBAction func btnSelectTypeAction(_ sender: Any) {
        presentToDropDown()
    }
    
    @IBAction func btnCreateAccAction(_ sender: Any) {
        if tfName.text?.isEmptyOrWhitespace() ?? false{
            UtilityMangr.shared.showAlert(title: AppConstant.kOops, msg: AppConstant.kEmptyName, vwController: self)
        }else if tfEmail.text?.isEmptyOrWhitespace() ?? false{
            UtilityMangr.shared.showAlert(title: AppConstant.kOops, msg: AppConstant.kEmptyEmail, vwController: self)
        }else if !(UtilityMangr.shared.isValidEmail(testStr: tfEmail.text ?? "")){
            UtilityMangr.shared.showAlert(title: AppConstant.kOops, msg: AppConstant.kValidEmail, vwController: self)
        }else if tfPassword.text?.isEmptyOrWhitespace() ?? false{
            UtilityMangr.shared.showAlert(title: AppConstant.kOops, msg: AppConstant.kEmptyPassword, vwController: self)
        }else if tfPhoneNo.text?.isEmptyOrWhitespace() ?? false{
            UtilityMangr.shared.showAlert(title: AppConstant.kOops, msg: AppConstant.kEmptyPhoneNo, vwController: self)
        }else if tfType.text?.isEmptyOrWhitespace() ?? false && selectedKeyValue == ""{
            UtilityMangr.shared.showAlert(title: AppConstant.kOops, msg: AppConstant.kEmptyType, vwController: self)
        }else{
            registerAPI()
        }
    }
    
    
}

//MARK: NAVIGATION
extension CreateAccountVC{
    
    func presentToDropDown(){
        let vc = DropDownVC.getVC(.Main)
        vc.selectedIndex = selectedIndex
        vc.selectedType = { [weak self] (title,keyValue,index) in
            self?.selectedIndex = index
            self?.tfType.text = title
            self?.selectedKeyValue = keyValue
        }
        self.present(vc, animated: true)
    }
    
    func pushToVerifyOtp(objParm:ParamApiModel){
        let vc = VerifyOtpVC.getVC(.Main)
        vc.mobileNumber = "+91\(tfPhoneNo.text ?? "")"
        vc.objParamApiModel = objParm
        self.push(vc)
    }
    
}

//MARK: API
extension CreateAccountVC{
    
    func registerAPI(){
        
        let param = ParamApiModel(endPoint: APIConstant.kRegister,
                                  email: tfEmail.text ?? "",
                                  full_name: tfName.text ?? "",
                                  phone: "+91\(tfPhoneNo.text ?? "")",
                                  password: tfPassword.text ?? "",
                                  type: selectedKeyValue)
        
        UserViewModel.shared().registerAPI(paramApi: param) { [weak self] (success,msg) in
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
