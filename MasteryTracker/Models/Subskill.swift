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
