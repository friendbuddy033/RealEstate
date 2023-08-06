//
//  HomeVillaVC.swift
//  RealEstate
//
//  Created by Surinder kumar on 25/06/23.
//

import UIKit

class HomeVillaVC: UIViewController {
    
    @IBOutlet weak var clcVw: UICollectionView!{
        didSet{
            clcVw.delegate = self
            clcVw.dataSource = self
            clcVw.registerNib(cell: HomeVillaClcCell.self)
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
extension HomeVillaVC:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeVillaClcCell", for: indexPath) as! HomeVillaClcCell
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
        return CGSize(width: ((clcVw.frame.width - 10)/2), height: 209)
    }
}
