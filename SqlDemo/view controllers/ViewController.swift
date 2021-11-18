//
//  ViewController.swift
//  SqlDemo
//
//  Created by Mac on 09/10/21.
//

import UIKit

class ViewController: UIViewController {
    var userArray = [User]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    }
//MARK: 
    func apiData() {
        let apiString = "https://jsonplaceholder.typicode.com/users"
        if let apiUrl = URL(string: apiString){
            let session = URLSession(configuration: .default)
            let dataTask = session.dataTask(with: apiUrl) { DataFromServer, response, error in
                guard let data = DataFromServer else{
                    print("data is not present")
                    return
                }
                guard let json = try! JSONSerialization.jsonObject(with: data, options: [])as? [[String:Any]] else{
                    print("json not well formated")
                    return
                }
                for data in json{
                    let user = User(id: (data["id"]as? Int) ?? 0, name: (data["name"]as? String) ?? "", userName: (data["username"]as? String) ?? "", email: (data["email"]as? String) ?? "", address: (data["address"]as? String) ?? "")
                    self.userArray.append(user)
                }
            }
            dataTask.resume()
        }else{
            print("url is not present")
        }
    }
    @IBAction func apiBtnAction(_ sender: Any) {
        
       if  let vc2Obj = storyboard?.instantiateViewController(identifier: "SecondViewController")as? SecondViewController{
        apiData()
        vc2Obj.users = userArray
        navigationController?.pushViewController(vc2Obj, animated: true)
        }
    }

}

