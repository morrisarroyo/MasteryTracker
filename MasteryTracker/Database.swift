//
//  Database.swift
//  MasteryTracker
//
//  Created by Morris Arroyo on 2017-10-22.
//  Copyright © 2017 BCIT. All rights reserved.
//

import Foundation
import SQLite

class Database {
    let path : String
    let db : Any
    init () {
        path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        do {
            db  = try Connection("\(path)/db.sqlite3")
        } catch {
            fatalError("Could not connect to database")
        }
           
            
    }
        
   
}
