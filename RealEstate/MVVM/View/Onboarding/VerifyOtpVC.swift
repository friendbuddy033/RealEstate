//
//  VerifyOtpVC.swift
//  RealEstate
//
//  Created by Surinder kumar on 23/07/23.
//

import UIKit

class VerifyOtpVC: UIViewController {

    @IBOutlet weak var tfSixth: TextFieldCustom!
    @IBOutlet weak var tfFiftth: TextFieldCustom!
    @IBOutlet weak var tfForth: TextFieldCustom!
    @IBOutlet weak var tfThird: TextFieldCustom!
    @IBOutlet weak var tfSecond: TextFieldCustom!
    @IBOutlet weak var tfFirst: TextFieldCustom!
    @IBOutlet weak var lblOtpDesc: UILabel!
    
    public var mobileNumber : String = ""
    public var role : String = ""
    public var verificationType : String = ""
    public var userId: Int = 0
    public var objParamApiModel : AuthParamApiModel?
    private var isOtpValid : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setUI()
    }
    
    @IBAction func btnResendAction(_ sender: Any) {
    }
    
    @IBAction func btnVerifyAction(_ sender: Any) {
        [tfFirst,tfSecond,tfThird,tfForth,tfFiftth,tfSixth].forEach { [weak self] (txtFld) in
            if txtFld?.text?.isEmptyOrWhitespace() ?? false{
                UtilityMangr.shared.showAlert(title: AppConstant.kOops, msg: AppConstant.kValidOtp, vwController: self ?? UIViewController())
                self?.isOtpValid = false
                return
            }else{
                self?.isOtpValid = true
            }
        }
        isOtpValid == true ? verifyotp() : nil
    }
    
}

//MARK: SETUI
extension VerifyOtpVC{
    
    func setUI(){
        lblOtpDesc.text = "We have send the OTP on \(mobileNumber)\nwill apply auto to the fields"
        [tfFirst,tfSecond,tfThird,tfForth,tfFiftth,tfSixth].forEach { [weak self] (txtFld) in
            txtFld?.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
        }
    }
    
}

//MARK: TEXTFIELD OTP CURSOR
extension VerifyOtpVC{
    
    @objc func textFieldDidChange(textField: UITextField){

        let text = textField.text

        if text?.utf16.count ?? 0 >= 1{
            switch textField{
            case tfFirst:
                tfSecond.becomeFirstResponder()
            case tfSecond:
                tfThird.becomeFirstResponder()
            case tfThird:
                tfForth.becomeFirstResponder()
            case tfForth:
                tfFiftth.becomeFirstResponder()
            case tfFiftth:
                tfSixth.becomeFirstResponder()
            case tfSixth:
                tfSixth.resignFirstResponder()
            default:
                break
            }
        }else{

        }
        
        if (text?.utf16.count)! == 0 {
            switch textField{
            case tfFirst:
                tfFirst.becomeFirstResponder()
            case tfSecond:
                tfFirst.becomeFirstResponder()
            case tfThird:
                tfSecond.becomeFirstResponder()
            case tfForth:
                tfThird.becomeFirstResponder()
            case tfFiftth:
                tfForth.becomeFirstResponder()
            case tfSixth:
                tfFiftth.becomeFirstResponder()
                
            default:
                break
            }
            
        }else{
            
        }
        
        
    }
    
}

//MARK: API
extension VerifyOtpVC{
    
    func verifyotp(){
        let otp = "\(tfFirst.text ?? "")\(tfSecond.text ?? "")\(tfThird.text ?? "")\(tfForth.text ?? "")\(tfFiftth.text ?? "")\(tfSixth.text ?? "")"
        
        var params : AuthParamApiModel!
        
        if self.verificationType == APIConstant.kLogin{
            params = AuthParamApiModel(endPoint: APIConstant.kVerifyCode,
                                       type: self.verificationType,
                                       code: otp,
                                       userID: self.userId)
        }else{
            params = AuthParamApiModel(endPoint: APIConstant.kVerifyCode,
                                          email: objParamApiModel?.email ?? "",
                                          full_name: objParamApiModel?.full_name ?? "",
                                          phone: objParamApiModel?.phone ?? "",
                                          password: objParamApiModel?.password ?? "",
                                          type: self.verificationType,
                                          userType: objParamApiModel?.type ?? "",
                                          code: otp)
        }
        
        UserViewModel.shared().verifyOtpAPI(paramApi: params) { [weak self] (success,msg,userId) in
            if success{
                guard let self = self else { return }
                if self.verificationType == APIConstant.kLogin{
                    if UtilityMangr.shared.getUserDetail()?.role == "property_agent"{
                        UtilityMangr.shared.makeAgentTabRoot()
                    }else{
                        UtilityMangr.shared.makeUserTabRoot()
                    }
                }else{
                    if self.objParamApiModel?.type == "property_agent"{
                        let vc = AgentRegistStepOneVC.getVC(.Agent)
                        vc.userId = userId
                        self.push(vc)
                    }else{
                        UtilityMangr.shared.makeUserTabRoot()
                    }
                }
            }else{
                UtilityMangr.shared.showAlert(title: AppConstant.kError, msg: msg, vwController: self ?? UIViewController())
            }
        }
        
    }
    
}
