//
//  FilterVC.swift
//  RealEstate
//
//  Created by jass Dhariwal on 24/06/23.
//

import UIKit

class FilterVC: UIViewController {

    @IBOutlet weak var tblVwFiltersOptions: UITableView!{
        didSet{
            tblVwFiltersOptions.registerNib(cell: FilterOptionCell.self)
            tblVwFiltersOptions.delegate = self
            tblVwFiltersOptions.dataSource = self
        }
    }
    @IBOutlet weak var tblVwFilterTypes: UITableView!{
        didSet{
            tblVwFilterTypes.registerNib(cell: FilterTypeCell.self)
            tblVwFilterTypes.delegate = self
            tblVwFilterTypes.dataSource = self
        }
    }
    
    private var selectedOptionIndex = -1
    private var selectedTypeIndex = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func btnCrossAction(_ sender: UIButton){
        self.dismiss(animated: true)
    }
}
extension FilterVC: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == tblVwFiltersOptions{
            let cell = tableView.dequeueReusableCell(withIdentifier: FilterOptionCell.identifier, for: indexPath) as! FilterOptionCell
            
            cell.selectionStyle = .none

            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: FilterTypeCell.identifier, for: indexPath) as! FilterTypeCell
            
            cell.selectionStyle = .none
            cell.isSelectedCategory = indexPath.row == selectedTypeIndex

            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if tableView == tblVwFiltersOptions
        {
            self.selectedOptionIndex = indexPath.row
        }else{
            self.selectedTypeIndex = indexPath.row

        }
        
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 54
    }
    
}

