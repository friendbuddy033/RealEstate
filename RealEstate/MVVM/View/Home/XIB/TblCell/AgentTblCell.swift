//
//  AgentTblCell.swift
//  RealEstate
//
//  Created by Surinder kumar on 24/06/23.
//

import UIKit
protocol AgentInnerTappableDelegate{
    func didSelect(indexPath: IndexPath)
}
class AgentTblCell: UITableViewCell {

    @IBOutlet weak var clcVw: UICollectionView!{
        didSet{
            clcVw.delegate = self
            clcVw.dataSource = self
            clcVw.registerNib(cell: AgentClcCell.self)
            clcVw.registerNib(cell: PropertyClcCell.self)
        }
    }
    @IBOutlet weak var constraintHeightClcVw: NSLayoutConstraint!
    
    public enum cellTypes : String{
        case Agent = "Agent"
        case Property = "Property"
    }
    
    var cellType : cellTypes = .Agent
    var delegate : AgentInnerTappableDelegate? = nil
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

//MARK: - COLLECTIONVIEW DELEGATE AND DATASOURCE
extension AgentTblCell:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch cellType{
        case .Agent:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AgentClcCell", for: indexPath) as! AgentClcCell
            return cell
        case .Property:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PropertyClcCell", for: indexPath) as! PropertyClcCell
            cell.cellType = .regular

            return cell
        default:
            Logger.log("default")
        }
       
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.delegate?.didSelect(indexPath: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch cellType{
        case .Agent :
            return CGSize(width: (clcVw.frame.width - 10)/2, height: 194)
        case .Property:
            return CGSize(width: 236, height: 261)
        }
        
    }
    
}
