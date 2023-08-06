//
//  LoginVC.swift
//  RealEstate
//
//  Created by Apple on 25/07/23.
//

import UIKit
import CountryPickerView

class LoginVC: UIViewController {

    @IBOutlet weak var tfPhoneNo: TextFieldCustom!
    @IBOutlet weak var vwBg: UIView!
    @IBOutlet weak var imageFlag: ImageCustom!
    @IBOutlet weak var labelCountryCode: UILabel!
    
    private var countryCode: String = "+64"
    private let countryPicker = CountryPickerView()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        countryPicker.delegate = self
        let country = countryPicker.getCountryByPhoneCode("+64")
        imageFlag.image = country?.flag
    }
    

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        vwBg.roundCorners(with: [.layerMinXMinYCorner,.layerMaxXMinYCorner], radius: 45)
    }

    @IBAction func btnCountryCodeAction(_ sender: Any){
        countryPicker.showCountriesList(from: self)
    }
    
    @IBAction func btnGetOtpAction(_ sender: Any) {
        if tfPhoneNo.text == ""{
            UtilityMangr.shared.showAlert(title: AppConstant.kOops, msg: AppConstant.kEmptyPhoneNo, vwController: self)
        }else if countryCode == ""{
            UtilityMangr.shared.showAlert(title: AppConstant.kOops, msg: AppConstant.kEmptyCountryCode, vwController: self)
        } else{
            self.loginAPI()
        }
    }
    
    @IBAction func btnCreateAccAction(_ sender: Any) {
        self.push(CreateAccountVC.getVC(.Main))
    }
}
extension LoginVC{
    
    func pushToVerifyOtp(userId: Int){
        let vc = VerifyOtpVC.getVC(.Main)
        vc.mobileNumber = "\(self.countryCode)\(tfPhoneNo.text ?? "")"
        vc.verificationType = APIConstant.kLogin
        vc.userId = userId
        self.push(vc)
    }

    
}
extension LoginVC: CountryPickerViewDelegate{
    
    func countryPickerView(_ countryPickerView: CountryPickerView, didSelectCountry country: Country)
    {
        self.countryCode = country.phoneCode
        self.imageFlag.image = country.flag
        self.labelCountryCode.text = country.phoneCode
    }
    
    
}
//MARK: API
extension LoginVC{
    
    func loginAPI()
    {
        let param = AuthParamApiModel(endPoint: APIConstant.kLogin,
                                      phone: "\(self.countryCode)\(tfPhoneNo.text ?? "")",
                                      device_id: UIDevice.current.identifierForVendor?.uuidString ?? "",
                                      device_token: "fsdsd655dfdfdf",
                                      device_type: "ios")
        
        UserViewModel.shared().loginAPI(paramApi: param) { [weak self] (success,msg,userId) in
            if success{
                UtilityMangr.shared.showAlertWithCompletion(title: "", msg: msg, vwController: self ?? UIViewController()) { [weak self] in
//                    self?.push(RealEstateTabbarVC.getVC(.Tabbbar))
                    self?.pushToVerifyOtp(userId: userId)
                }
            }else{
                UtilityMangr.shared.showAlert(title: AppConstant.kError, msg: msg, vwController: self ?? UIViewController())
            }
        }
    }
    
}
