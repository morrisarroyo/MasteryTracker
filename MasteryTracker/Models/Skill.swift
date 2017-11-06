//
//  Skill.swift
//  MasteryTracker
//
//  Created by Morris Arroyo on 2017-10-20.
//  Copyright © 2017 BCIT. All rights reserved.
//

import UIKit
import SQLite

class Skill {
    static let tableName: String = "skills"
    static let tcId = Expression<Int>("id")
    static let tcName = Expression<String>("name")
    static let tcRating = Expression<Int>("rating")
    static let tcMasteryId = Expression<Int>("masteryId")
    static let minRating: Int = 0
    static let maxRating: Int = 5
    
    var id: Int
    var name : String
    var rating : Int
    var masteryId : Int = 1
    
    //Mark Initialization
    init?(id: Int, name: String, rating: Int, masteryId : Int = 1) {
        
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
    }
    
    static func getSkillForId(num: Int) -> Skill {
        let db = Database().db
        let id = Expression<Int>("id")
        let name = Expression<String>("name")
        let rating = Expression<Int>("rating")
        let masteryId = Expression<Int>("masteryId")
        
        let skillsTable = Table(tableName)
        let query = skillsTable.filter(id == num)
        var ski: Skill?
        do {
            if let skill = try db.pluck(query) {
                ski = Skill(id: try skill.get(id),  name: try skill.get(name), rating: try skill.get(rating), masteryId: try skill.get(masteryId))
            }
            return ski!
        } catch {
            print("Failed to get list of skills from database");
        }
        return ski!
    }
    
    func incrementRating() -> Int {
        let temp = rating + 1;
        if(validateRating(rating: temp)) {
            let db = Database().db
            let table = Table(Skill.tableName)
            let skillRow = table.filter(Skill.tcId == id)
            do {
                if(try db.run(skillRow.update(Skill.tcRating <- temp)) > 0) {
                    rating = temp
                }
            } catch {
                print("failed to increment skill rating - Skill")
            }
        }
        return rating
    }
    
    func decrementRating() -> Int {
        let temp = rating - 1;
        if(validateRating(rating: temp)) {
            let db = Database().db
            let table = Table(Skill.tableName)
            let skillRow = table.filter(Skill.tcId == id)
            do {
                if(try db.run(skillRow.update(Skill.tcRating <- temp)) > 0) {
                    rating = temp
                }
            } catch {
                print("failed to increment skill rating - Skill")
            }
        }
        return rating
    }
    
    func validateRating(rating: Int) -> Bool {
        return (rating >= Subskill.minRating && rating <= Subskill.maxRating)
    }
        
    static func getSkillsForMastery(num : Int = 1) -> [Skill]{
        let id = Expression<Int>("id")
        let name = Expression<String>("name")
        let rating = Expression<Int>("rating")
        let masteryId = Expression<Int>("masteryId")
        
        let db = Database().db
        let skillsTable = Table(tableName)
        var skills = [Skill]()
        let query = skillsTable.filter(masteryId == num)
        do {
            for skill in try db.prepare(query) {
                let ski = Skill(id: try skill.get(id),  name: try skill.get(name), rating: try skill.get(rating), masteryId: try skill.get(masteryId))
                skills.append(ski!)
            }
        } catch {
            print("Failed to get list of skills from database");
        }
        return skills
    }
    
    static func listSkillsRows() {
        let id = Expression<Int>("id")
        let name = Expression<String>("name")
        //let rating = Expression<Int>("rating")
        let masteryId = Expression<Int>("masteryId")
        
        let db = Database().db
        let skillsTable = Table(tableName)
        do {
            for skill in try db.prepare(skillsTable) {
                print((try skill.get(name)) + String(try skill.get(id)) + String(try skill.get(masteryId)))
            }
        } catch {
            print("Failed to get list of skills from database");
        }
    }
}
