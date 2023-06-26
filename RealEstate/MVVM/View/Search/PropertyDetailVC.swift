//
//  PopertyDetailVC.swift
//  RealEstate
//
//  Created by jass Dhariwal on 25/06/23.
//

import UIKit

class PropertyDetailVC: UIViewController {

    @IBOutlet weak var clcVwImages: UICollectionView!{
        didSet{
            clcVwImages.registerNib(cell: PropertyImagesCell.self)
            clcVwImages.delegate = self
            clcVwImages.dataSource = self
        }
    }
    
    @IBOutlet weak var tblVwAdditionalDetails: UITableView!{
        didSet{
            tblVwAdditionalDetails.registerNib(cell: AdditionalDetailCell.self)
            tblVwAdditionalDetails.delegate = self
            tblVwAdditionalDetails.dataSource = self
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func btnBackAction(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }

}
extension PropertyDetailVC : UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PropertyImagesCell.identifier, for: indexPath) as! PropertyImagesCell
        
        cell.imageVw.layer.cornerRadius = 10
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.bounds.size
    }
    
}
extension PropertyDetailVC: UITableViewDelegate, UITableViewDataSource
{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AdditionalDetailCell.identifier, for: indexPath) as! AdditionalDetailCell
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
}
