//
//  ProfessionalPhotoVC.swift
//  RealEstate
//
//  Created by Surinder kumar on 02/07/23.
//

import UIKit

class ProfessionalPhotoVC: UIViewController {

    @IBOutlet weak var clcVw: UICollectionView!{
        didSet{
            clcVw.delegate = self
            clcVw.dataSource = self
            clcVw.registerNib(cell: ProfessionalPhotoClcCell.self)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBarController?.tabBar.isHidden =  true
    }
    
    @IBAction func btnBackAction(_ sender: Any) {
        self.popVc()
    }

}

//MARK: - COLLECTIONVIEW DELEGATE AND DATASOURCE
extension ProfessionalPhotoVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfessionalPhotoClcCell", for: indexPath) as! ProfessionalPhotoClcCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
//
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: ((clcVw.frame.width - 10)/2), height: 175)
    }
}
