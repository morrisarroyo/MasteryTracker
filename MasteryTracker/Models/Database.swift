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
        createCriteriaTypesTable()
        createCriteriasTable()
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
            print("Could not create skills table")
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
            print("Could not create expertises table")
        }
        
        /*
        do {
            try db.run(expertises.insert(or: .replace, name <- "Mango", rating <- 2, tracked <- true, subskillId <- 0))
            try db.run(expertises.insert(or: .replace, name <- "Facial Muscles", rating <- 1, tracked <- true, subskillId <- 0))
            try db.run(expertises.insert(or: .replace, name <- "Torso Structure", rating <- 1, tracked <- true, subskillId <- 1))
            try db.run(expertises.insert(or: .replace, name <- "Torso Muscles", rating <- 2, tracked <- false, subskillId <- 1))
        } catch {
            print("insertion failed: \(error)")
        }
        */
    }
    
    func createCriteriaTypesTable()
    {
        let id = Expression<Int>("id")
        let type = Expression<String>("type")
        
        let criteriaTypes = Table("criteriaTypes")
        do {
            try db.run(criteriaTypes.create(ifNotExists: true) { t in
                t.column(id, primaryKey: true)
                t.column(type, unique: true)
            })
        } catch {
            print("Could not create criteriaTypes table")
        }
        
        do {
            try db.run(criteriaTypes.insert(or: .replace, id <- 0, type <- "Mastery"))
            try db.run(criteriaTypes.insert(or: .replace, id <- 1, type <- "Skill"))
            try db.run(criteriaTypes.insert(or: .replace, id <- 2, type <- "Subskill"))
            try db.run(criteriaTypes.insert(or: .replace, id <- 3, type <- "Expertise"))
        } catch {
            print("insertion failed: \(error)")
        }
    }
    
    func createCriteriasTable()
    {
        let id = Expression<Int>("id")
        let rating = Expression<Int>("rating")
        let name = Expression<String>("name")
        let description = Expression<String>("description")
        let typeId = Expression<Int>("typeId")
        
        let criterias = Table("criterias")
        do {
            try db.run(criterias.create(ifNotExists: true) { t in
                t.column(id, primaryKey: .autoincrement)
                t.column(rating)
                t.column(name)
                t.column(description)
                t.column(typeId)
            })
        } catch {
            print("Could not create criterias table")
        }
        let mastery0 = "Naive"
        let mastery1 = "Beginner"
        let mastery2 = "Intermediate"
        let mastery3 = "Adept"
        let mastery4 = "Expert"
        let mastery5 = "Master"
        
        let desc0 = "No knowledge"
        let desc1 = "Some knowledge and/or miniscule practice"
        let desc2 = "Little practice and requires reference"
        let desc3 = "Some practice and consults reference"
        let desc4 = "Extensive practice and glances reference"
        let desc5 = "Complete understanding of this"
        
        let type0 = "Mastery"
        let type1 = "Skill"
        let type2 = "Subskill"
        let type3 = "Expertise"
        //let desc5Ex = "More than 20hrs of practice for this Expertise"
        do {
            try db.run(criterias.insert(or: .replace, rating <- 0, name <- mastery0, description <- desc0, typeId <- 3))
            try db.run(criterias.insert(or: .replace, rating <- 1, name <- mastery1, description <- desc1, typeId <- 3))
            try db.run(criterias.insert(or: .replace, rating <- 2, name <- mastery2, description <- desc2, typeId <- 3))
            try db.run(criterias.insert(or: .replace, rating <- 3, name <- mastery3, description <- desc3, typeId <- 3))
            try db.run(criterias.insert(or: .replace, rating <- 4, name <- mastery4, description <- desc4, typeId <- 3))
            try db.run(criterias.insert(or: .replace, rating <- 5, name <- mastery5, description <- "\(desc5) \(type3)", typeId <- 3))
        } catch {
            print("insertion failed: \(error)")
        }
    }
}
