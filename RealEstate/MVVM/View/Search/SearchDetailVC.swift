//
//  SearchDetailVC.swift
//  RealEstate
//
//  Created by jass Dhariwal on 24/06/23.
//

import UIKit

class SearchDetailVC: UIViewController {

    @IBOutlet weak var clcVw: UICollectionView!{
        didSet{
            clcVw.registerNib(cell: PropertyClcCell.self)
            clcVw.delegate = self
            clcVw.dataSource = self
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension SearchDetailVC: UICollectionViewDelegate, UICollectionViewDataSource , UICollectionViewDelegateFlowLayout
{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PropertyClcCell.identifier, for: indexPath) as! PropertyClcCell
//        cell.cellType = .small
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width/2 - 15, height: 210)
    }
    
}
