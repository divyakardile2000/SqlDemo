//
//  ThirdViewController.swift
//  SqlDemo
//
//  Created by Mac on 09/10/21.
//

import UIKit
import SQLite3
class ThirdViewController: UIViewController {
    var db : OpaquePointer?

    @IBOutlet weak var IdLabel: UILabel!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    var id : Int?
    var name : String?
    var userName : String?
    var email : String?
    var address : String?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let id1 = id else {
            return
        }
        IdLabel.text = String(id1)
        nameLabel.text = name
        userNameLabel.text = userName
        emailLabel.text = email
        addressLabel.text = address
        
        let  fileUrl = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("HeroDatabase.sqlite")
        
        if sqlite3_open(fileUrl.path, &db) != SQLITE_OK{
            print("error opening database")
            return
        }
        
        let createTableQuery = "CREATE TABLE IF NOT EXISTS Hero(id INTEGER PRIMARY KEY, name TEXT, userName TEXT , email TEXT)"
        
       if sqlite3_exec(db, createTableQuery, nil, nil, nil) != SQLITE_OK{
            print("error creating table")
        return
        }
        print("everything is fine")
    }
    
    
    @IBAction func bookmarkBtnAction(_ sender: Any) {
        
        let id = IdLabel.text?.trimmingCharacters(in: .whitespaces)
        let name = nameLabel.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let userName = userNameLabel.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        let email = emailLabel.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        
        
        if(name?.isEmpty)!{
            print("name is empty")
            return
        }
        
        
        if(id?.isEmpty)!{
            print("id is empty")
            return
        }
        
        if(email?.isEmpty)!{
            print("name is empty")
            return
        }
        
        
        if(userName?.isEmpty)!{
            print("id is empty")
            return
        }
        
        var stmnt: OpaquePointer?
        
        let insertQuery = "INSERT INTO Hero (id , name , userName , email) VALUES (?,?,?,?)"
        if sqlite3_prepare(db, insertQuery, -1, &stmnt, nil) != SQLITE_OK{
            print("error binding query")
        }
        if sqlite3_bind_int(stmnt, 1, (id! as NSString).intValue) != SQLITE_OK{
           print("error in bind rank")
        }
        
        
        if sqlite3_bind_text(stmnt, 2, name, -1, nil) != SQLITE_OK{
            print("error in bind name")
        }
        
        if sqlite3_bind_text(stmnt, 3, userName, -1, nil) != SQLITE_OK{
            print("error in bind username")
        }
        
        if sqlite3_bind_text(stmnt, 4, email, -1, nil) != SQLITE_OK{
            print("error in bind email")
        }
        
        
        if sqlite3_step(stmnt) == SQLITE_DONE{
            print("data save succc........")
        }
        
        
    }
        
    }
    
    
    

