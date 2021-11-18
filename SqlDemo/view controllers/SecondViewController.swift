//
//  SecondViewController.swift
//  SqlDemo
//
//  Created by Mac on 09/10/21.
//

import UIKit

class SecondViewController: UIViewController {
    var users = [User]()
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self

    }
  

}

extension SecondViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        250
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let user = users[indexPath.row]
       if let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell", for: indexPath)as? CustomTableViewCell{
        cell.idLabel.text = String(user.id)
        cell.nameLabel.text = user.name
        return cell
        } else{
            return UITableViewCell()
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = users[indexPath.row]
      if   let vc3obj = storyboard?.instantiateViewController(identifier: "ThirdViewController")as? ThirdViewController{
        vc3obj.id = user.id
        vc3obj.name = user.name
        vc3obj.userName = user.userName
        vc3obj.email = user.email
        vc3obj.address = user.address
            navigationController?.pushViewController(vc3obj, animated: true)
        }
        
    }
    
    
}
