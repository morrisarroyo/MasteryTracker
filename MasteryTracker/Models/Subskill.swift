//
//  Subskill.swift
//  MasteryTracker
//
//  Created by Morris Arroyo on 2017-10-20.
//  Copyright © 2017 BCIT. All rights reserved.
//

import UIKit
import SQLite

class Subskill: NSObject {

    //MARK: Properties
    static let tableName: String = "subskills"
    static let tcId = Expression<Int>("id")
    static let tcName = Expression<String>("name")
    static let tcRating = Expression<Int>("rating")
    static let tcSkillId = Expression<Int>("skillId")
    static let minRating: Int = 0
    static let maxRating: Int = 5
    
    var id: Int
    var name: String
    var rating: Int
    var skillId: Int
    
    //MARK: Initialization
    init?(id: Int, name: String, rating: Int,  skillId: Int) {
       
        // The name must not be empty
        guard !name.isEmpty else {
            return nil
        }
        
        // The rating must be between 0 and 5 inclusively
        guard (rating >= 0) && (rating <= 5) else {
            return nil
        }
        
        self.id = id
        self.name = name
        self.rating = rating
        self.skillId = skillId
    }
    
    func incrementRating() -> Int {
        let temp = rating + 1;
        if(validateRating(rating: temp)) {
            let db = Database().db
            let table = Table(Subskill.tableName)
            let subskillRow = table.filter(Subskill.tcId == id)
            do {
                if(try db.run(subskillRow.update(Subskill.tcRating <- temp)) > 0) {
                    rating = temp
                }
            } catch {
                print("failed to increment subskill rating")
            }
        }
        return rating
    }
    
    func decrementRating() -> Int {
        let temp = rating - 1;
        if(validateRating(rating: temp)) {
            let db = Database().db
            let table = Table(Subskill.tableName)
            let subskillRow = table.filter(Subskill.tcId == id)
            do {
                if(try db.run(subskillRow.update(Subskill.tcRating <- temp)) > 0) {
                    rating = temp
                }
                print(rating)
            } catch {
                print("failed to increment subskill rating")
            }
        }
        return rating
    }
    
    func validateRating(rating: Int) -> Bool {
        return (rating >= Subskill.minRating && rating <= Subskill.maxRating)
    }
    
    static func getSubskillForId(id: Int) -> Subskill {
        let db = Database().db
        
        let skillsTable = Table(tableName)
        let query = skillsTable.filter(tcId == id)
        var subskill: Subskill?
        do {
            if let ssk = try db.pluck(query) {
                subskill = Subskill(id: try ssk.get(tcId),  name: try ssk.get(tcName), rating: try ssk.get(tcRating), skillId: try ssk.get(tcSkillId))
            }
            return subskill!
        } catch {
            print("Failed to get list of skills from database");
        }
        return subskill!
    }
    
    static func getSubskillsForSkill(num : Int) -> [Subskill]{
        let id = Expression<Int>("id")
        let name = Expression<String>("name")
        let rating = Expression<Int>("rating")
        let skillId = Expression<Int>("skillId")
        
        let db = Database().db
        let subskillsTable = Table(tableName)
        var subskills = [Subskill]()
        let query = subskillsTable.filter(skillId == num)
        do {
            for subskill in try db.prepare(query) {
                let sub = Subskill(id: try subskill.get(id),  name: try subskill.get(name), rating: try subskill.get(rating), skillId: try subskill.get(skillId))
                subskills.append(sub!)
            }
        } catch {
            print("Failed to get list of subskills from database");
        }
        return subskills
    }
    
    static func listSubskillsRows() {
        let id = Expression<Int>("id")
        let name = Expression<String>("name")
        //let rating = Expression<Int>("rating")
        let skillId = Expression<Int>("skillId")
        
        let db = Database().db
        let subskillsTable = Table(tableName)
        do {
            for subskill in try db.prepare(subskillsTable) {
                print((try subskill.get(name)) + String(try subskill.get(id)) + String(try subskill.get(skillId)))
            }
        } catch {
            print("Failed to get list of subskills from database");
        }
    }
}
