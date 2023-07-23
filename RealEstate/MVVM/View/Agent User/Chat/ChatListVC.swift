//
//  ChatListVC.swift
//  RealEstate
//
//  Created by Apple on 10/07/23.
//

import UIKit

class ChatListVC: UIViewController {

    @IBOutlet weak var tblVwChat: UITableView!{
        didSet{
            tblVwChat.delegate = self
            tblVwChat.dataSource = self
            tblVwChat.registerNib(cell: LastMessageCell.self)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    

}
extension ChatListVC : UITableViewDelegate, UITableViewDataSource
{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: LastMessageCell.identifier, for: indexPath) as! LastMessageCell
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.push(ChatVC.getVC(.Chat))
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    }
    
}
