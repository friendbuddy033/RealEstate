//
//  AgentsVC.swift
//  RealEstate
//
//  Created by jass Dhariwal on 26/06/23.
//

import UIKit

class AgentsVC: UIViewController {

    @IBOutlet weak var clcVwAgents: UICollectionView!{
        didSet{
            clcVwAgents.registerNib(cell: AgentClcCell.self)
            clcVwAgents.delegate = self
            clcVwAgents.dataSource = self
        }
    }
    @IBOutlet weak var tblVwOptions: UITableView!{
        didSet{
            tblVwOptions.registerNib(cell: AgentsOptionsCell.self)
            tblVwOptions.delegate = self
            tblVwOptions.dataSource = self
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    
    
}
extension AgentsVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AgentClcCell", for: indexPath) as! AgentClcCell
        return cell

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width - 10)/2, height: 191)
    }
    
//    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
//        let vw = HeaderView.instance
//        vw.lblTitle.text = headerSection.allCases[section].rawValue
//        vw.btnSeeMore.isHidden = headerSection.allCases[section].rawValue == headerSection.HireAgent.rawValue ? false : true
//        return vw

//    }
    
}
extension AgentsVC : UITableViewDelegate, UITableViewDataSource
{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AgentsOptionsCell.identifier, for: indexPath) as! AgentsOptionsCell
        
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
}
