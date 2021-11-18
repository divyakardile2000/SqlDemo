//
//  ViewController.swift
//  sqliteDemo
//
//  Created by Mac on 10/10/21.
//

import UIKit
import SQLite3


class ViewController: UIViewController {
    var db : OpaquePointer?

    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var rankTF: UITextField!
    @IBAction func saveBtnAction(_ sender: Any) {
        let name = nameTF.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        
            let powerRank = rankTF.text?.trimmingCharacters(in: .whitespacesAndNewlines)
        if(name?.isEmpty)!{
            print("name is empty")
            return
        }
        
        if(powerRank?.isEmpty)!{
            print("rank is empty")
            return
        }
        
        var statmnt : OpaquePointer?
        
        let insertQuery = "INSERT INTO heroes (name, powerrank) VALUES (?, ?)"
        
        if sqlite3_prepare(db, insertQuery, -1, &statmnt, nil) != SQLITE_OK{
            print("error binding query")
        }
        
        if sqlite3_bind_text(statmnt, 1, name, -1, nil) != SQLITE_OK{
            print("error binding name")
        }
        
        if sqlite3_bind_int(statmnt,2, (powerRank! as NSString).intValue) != SQLITE_OK{
            print("error binding rank")
        }
        
       if sqlite3_step(statmnt) != SQLITE_DONE{
            print("hero saved successfully.......")
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let fileUrl = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathComponent("HeroDatabase.sqlite")
        
        
        if sqlite3_open(fileUrl.path, &db) != SQLITE_OK{
            print("error opening database")
            return
        }
        
        
        let cerateTableQuery = "CREATE TABLE IF NOT EXISTS Heroes (id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, powerrank INTEGER)"
        
        
        if  sqlite3_exec(db, cerateTableQuery, nil, nil, nil) != SQLITE_OK{
            print("error to create table")
            return
        }
        
        print("everything is fine")
        
    }


}

