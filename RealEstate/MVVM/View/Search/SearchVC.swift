//
//  SearchVC.swift
//  RealEstate
//
//  Created by Surinder kumar on 24/06/23.
//

import UIKit

class SearchVC: UIViewController {
    
    @IBOutlet weak var tblVw: UITableView!{
        didSet{
            tblVw.delegate = self
            tblVw.dataSource = self
            tblVw.registerNib(cell: AgentTblCell.self)
        }
    }
    private enum headerSection : String,CaseIterable{
        case Properties = "Popular"
        case Enquiries = "Near by your location"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }

    @IBAction func btnSeeMoreAction(_ sender: UIButton)
    {
        self.push(SearchDetailVC.getVC(.Search))
    }

    @IBAction func btnFilterAction(_ sender: UIButton)
    {
//        self.push(SearchDetailVC.getVC(.Search))
        let vc = FilterVC.getVC(.Search)
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
}

//MARK: - TABLEVIEW DELEGATE AND DATASOURCE
extension SearchVC:UITableViewDelegate,UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return headerSection.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
         return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AgentTblCell", for: indexPath) as! AgentTblCell
        cell.cellType = .Property
        cell.constraintHeightClcVw.constant = 270
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let vw = HeaderView.instance
        vw.lblTitle.text = headerSection.allCases[section].rawValue
        return vw
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
}
extension SearchVC: AgentInnerTappableDelegate
{
    func didSelect(indexPath: IndexPath) {
        self.hidesBottomBarWhenPushed = true
        self.push(PropertyDetailVC.getVC(.Search))
        
    }
}
