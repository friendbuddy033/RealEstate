//
//  SavePropertyVC.swift
//  RealEstate
//
//  Created by Surinder kumar on 02/07/23.
//

import UIKit
import Photos

class SavePropertyVC: UIViewController {

    @IBOutlet weak var tblVw: UITableView!{
        didSet{
            tblVw.delegate = self
            tblVw.dataSource = self
            tblVw.registerNib(cell: TextFieldTblCell.self)
            tblVw.registerNib(cell: AddPictureTblCell.self)
        }
    }
    @IBOutlet weak var viewAddProfessionalPic: ViewCustom!
    @IBOutlet weak var viewAddMoreImages: ViewCustom!
    
    private enum headerTiles : String,CaseIterable{
        case AddMoney = "Add Money"
        case AddPictureSelf = "Add Picture Self"
    }
    
    private var selectedImages: [UIImage] = []
    var propertyParams: PropertyParamModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    
    @IBAction func btnBackAction(_ sender: Any) {
        self.popVc()
    }
    
    @IBAction func btnSaveAction(_ sender: Any) {
//        self.pushToSuccess()
        if propertyParams?.money == "" || propertyParams?.money == nil {
            UtilityMangr.shared.showAlert(title: AppConstant.kOops, msg: "Please enter amount of property", vwController: self)
        }else{
            if let propertyParams{
                self.saveProperty(params: propertyParams)
            }
        }
    }
    
    @IBAction func btnAddPictureProfessionalAction(_ sender: Any) {
        self.pushToPictureProfessional()
    }
    
    @IBAction func btnAddMoreImagesAction(_ sender: Any) {
        self.handleCameraTapAction()
    }
}
//extension SavePropertyVC:

//MARK: - TABLEVIEW DELEGATE AND DATASOURCE
extension SavePropertyVC:UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return headerTiles.allCases.count 
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch headerTiles.allCases[section]
        {
        case .AddMoney : return 1
        case .AddPictureSelf : return selectedImages.count == 0 ? 1 : selectedImages.count
            
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch headerTiles.allCases[indexPath.section]{
        case .AddMoney:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TextFieldTblCell", for: indexPath) as! TextFieldTblCell
            cell.selectionStyle = .none
            
            cell.tfAmount.addTarget(self, action: #selector(handleMoneyField(_ :)), for: .editingChanged)
            
            return cell
        case .AddPictureSelf:
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddPictureTblCell", for: indexPath) as! AddPictureTblCell
            cell.selectionStyle = .none
            if indexPath.row < self.selectedImages.count{
                cell.imgSelected.image = self.selectedImages[indexPath.row]
                cell.imgCamera.isHidden = true
                cell.lblPlaceholder.isHidden = true
            }else{
                cell.imgSelected.image = #imageLiteral(resourceName: "dashlineBg")
                cell.imgCamera.isHidden = false
                cell.lblPlaceholder.isHidden = false
            }
            return cell
        
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch headerTiles.allCases[indexPath.section]{
        
        case .AddMoney : break
        case .AddPictureSelf : self.handleCameraTapAction()
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let vw = HeaderView.instance
        vw.lblTitle.text = headerTiles.allCases[section].rawValue
        vw.lblTitle.font = UIFont(name: FontName.semiBold, size: 18)
        vw.lblTitle.textColor = AppColor.themeColor
        vw.btnSeeMore.isHidden = true
        return vw
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch headerTiles.allCases[indexPath.section]{
        
        case .AddMoney : return UITableView.automaticDimension
        case .AddPictureSelf : return 177
            
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 45
    }
    
  
    
}
extension SavePropertyVC
{
    private func handleCameraTapAction(){
        let imagePicker = OpalImagePickerController()
        presentOpalImagePickerController(imagePicker, animated: true,
            select: { (assets) in
                //Select Assets
//            self.selectedImages.removeAll()
            
            for i in 0..<assets.count{
                self.convertPHAssetToUIImage(phAsset: assets[i]) { image in
                    if let image{
                        self.selectedImages.append(image)
                    }
                    if i == assets.count - 1{
//                        self.propertyParams?.gallery = self.selectedImages.compactMap({$0.pngData()})
                        DispatchQueue.main.async {
                            self.viewAddMoreImages.isHidden = self.selectedImages.count == 0
                            self.viewAddProfessionalPic.isHidden = self.selectedImages.count > 0
                            self.tblVw.reloadData()
                        }
                    }
                }
            }
            imagePicker.dismiss(animated: true)
            
            }, cancel: {
                //Cancel
            })
    }
    
    func convertPHAssetToUIImage(phAsset: PHAsset, completion: @escaping (UIImage?) -> Void) {
        let imageManager = PHImageManager.default()
        let imageRequestOptions = PHImageRequestOptions()
        imageRequestOptions.isSynchronous = true // Change to true if you want synchronous behavior
        imageRequestOptions.deliveryMode = .highQualityFormat // Adjust as needed

        // Request image data for the PHAsset
        imageManager.requestImage(for: phAsset,
                                  targetSize: CGSize(width: phAsset.pixelWidth, height: phAsset.pixelHeight),
                                  contentMode: .aspectFit,
                                  options: imageRequestOptions) { (image, _) in
            completion(image)
        }
    }
}


//MARK: NAVIGATION
extension SavePropertyVC{
    
    @objc private func handleMoneyField(_ txtfield: UITextField){
        propertyParams?.money = txtfield.text
    }
    
    func pushToSuccess(){
        let vc = PropertyAddedSuccessVC.getVC(.More)
        self.push(vc)
    }
    
    func pushToPictureProfessional(){
        let vc = ProfessionalPhotoVC.getVC(.More)
        self.push(vc)
    }
    
}
extension SavePropertyVC
{
    private func saveProperty(params : PropertyParamModel)
    {
        PropertyViewModel.shared().addNewProperty(paramApi: params) { [weak self] (success, msg,propertyId) in
            guard let self = self else { return }
            if success{
                if self.selectedImages.count > 0 //&& !pushToNextStep
                {
                    let imageParams = PropertyParamModel(property_id: propertyId,endPoint: APIConstant.kAddPropertyImages)
                    
                    self.saveProprtyImages(params: imageParams,images: selectedImages.compactMap({$0.pngData()}))
                }else{
                    DispatchQueue.main.async {
                        UtilityMangr.shared.showAlertWithCompletion(title: AppConstant.kAppName, msg: msg ,vwController: self){
                            self.pushToSuccess()
                        }
                    }
                }
            }else{
                DispatchQueue.main.async {
                    UtilityMangr.shared.showAlert(title: AppConstant.kOops, msg: msg, vwController: self)
                }
            }
        }
    }
    
    
    private func saveProprtyImages(params : PropertyParamModel,images: [Data])
    {
        PropertyViewModel.shared().addPropertyImages(paramApi: params, images: images) { [weak self] (success, msg,propertyId) in
            guard let self = self else { return }
            if success{
                    DispatchQueue.main.async {
                        UtilityMangr.shared.showAlertWithCompletion(title: AppConstant.kAppName, msg: msg ,vwController: self){
                            self.pushToSuccess()
                        }
                    }
            }else{
                DispatchQueue.main.async {
                    UtilityMangr.shared.showAlert(title: AppConstant.kOops, msg: msg, vwController: self)
                }
            }
        }
    }
    
}
