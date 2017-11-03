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
    let db : Connection
    init () {
        path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        do {
            db  = try Connection("\(path)/db.sqlite3")
        } catch {
            fatalError("Could not connect to database")
        }
    }
    
    func createTables() {
        createSkillsTable()
        createExpertisesTable()
    }
    
    func createSkillsTable() {
        let id = Expression<Int>("id")
        let name = Expression<String>("name")
        let rating = Expression<Int>("rating")
        let masteryId = Expression<Int>("masteryId")
        
        let skills = Table("skills")
        
        do {
            try db.run(skills.create(ifNotExists: true) { t in
                t.column(id, primaryKey: .autoincrement)
                t.column(name, unique: true)
                t.column(rating)
                t.column(masteryId)
            })
        } catch {
            fatalError("Could not create skills table")
        }
    }
    
    func createExpertisesTable() {
        let id = Expression<Int>("id")
        let name = Expression<String>("name")
        let rating = Expression<Int>("rating")
        let tracked = Expression<Bool>("tracked")
        let subskillId = Expression<Int>("subskillId")
        
        let expertises = Table("expertises")
        do {
            try db.run(expertises.create(ifNotExists: true) { t in
                t.column(id, primaryKey: .autoincrement)
                t.column(name, unique: true)
                t.column(rating)
                t.column(tracked)
                t.column(subskillId)
            })
        } catch {
            fatalError("Could not create expertises table")
        }
        
        
        do {
            try db.run(expertises.insert(or: .replace, name <- "Mango", rating <- 2, tracked <- true, subskillId <- 0))
            try db.run(expertises.insert(or: .replace, name <- "Facial Muscles", rating <- 1, tracked <- true, subskillId <- 0))
            try db.run(expertises.insert(or: .replace, name <- "Torso Structure", rating <- 1, tracked <- true, subskillId <- 1))
            try db.run(expertises.insert(or: .replace, name <- "Torso Muscles", rating <- 2, tracked <- false, subskillId <- 1))
        } catch {
            print("insertion failed: \(error)")
        }
        
    }
}
