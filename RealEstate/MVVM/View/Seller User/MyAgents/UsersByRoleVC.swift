//
//  UsersByRoleVC.swift
//  RealEstate
//
//  Created by Apple on 05/08/23.
//

import UIKit

class UsersByRoleVC: UIViewController {

    @IBOutlet weak var collVw: UICollectionView!{
        didSet{
            collVw.delegate = self
            collVw.dataSource = self
            collVw.registerNib(cell: ProfessionalPhotoClcCell.self)
            collVw.register(UINib(nibName: collectionViewHeaderFooterReuseIdentifier, bundle: nil), forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier:collectionViewHeaderFooterReuseIdentifier)
        }
    }
    
    let collectionViewHeaderFooterReuseIdentifier = "UserSearchHeaderView"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    @IBAction func btnBackAction(_ sender: UIButton)
    {
        self.popVc()
    }
    
}
//MARK: - COLLECTIONVIEW DELEGATE AND DATASOURCE
extension UsersByRoleVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfessionalPhotoClcCell", for: indexPath) as! ProfessionalPhotoClcCell
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "UserSearchHeaderView", for: indexPath) as! UserSearchHeaderView
        return view
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 13, bottom: 5, right: 13)
    }
        
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: ((collVw.frame.width - 10)/2), height: 175)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
            return CGSize(width: collectionView.frame.width, height: 250)
    }

    
}
