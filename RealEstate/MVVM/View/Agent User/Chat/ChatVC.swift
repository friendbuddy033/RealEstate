//
//  ChatVC.swift
//  RealEstate
//
//  Created by Apple on 10/07/23.
//

import UIKit

class ChatVC: UIViewController {

    @IBOutlet weak var tblVwChat: UITableView!{
        didSet{
            tblVwChat.delegate = self
            tblVwChat.dataSource = self
            tblVwChat.registerNib(cell: ReceiverChatCell.self)
            tblVwChat.registerNib(cell: SenderChatCell.self)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = true
    }
    
    @IBAction func btnBackAction(_ sender: UIButton){
        self.popVc()
    }

}
extension ChatVC : UITableViewDelegate, UITableViewDataSource
{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if (indexPath.row % 2) == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: SenderChatCell.identifier, for: indexPath) as! SenderChatCell
            cell.selectionStyle = .none
            return cell

        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: ReceiverChatCell.identifier, for: indexPath) as! ReceiverChatCell
            cell.selectionStyle = .none
            return cell

        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
