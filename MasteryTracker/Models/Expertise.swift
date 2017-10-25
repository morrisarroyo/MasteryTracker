//
//  Expertise.swift
//  
//
//  Created by Morris Arroyo on 2017-10-20.
//

import UIKit
import SQLite

class Expertise {
    
    //MARK: Properties
    let tableName: String = "expertises"
    var id: Int
    var name: String
    var rating: Int
    var tracked: Bool
    var subskillId: Int
    
    //MARK: Initialization
    init?(id: Int, name: String, rating: Int, tracked: Bool = false, subskillId: Int) {
        
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
        self.tracked = tracked
        self.subskillId = subskillId
    }
    
    static func listExpertisesRows() {
        let id = Expression<Int>("id")
        let name = Expression<String>("name")
        let rating = Expression<Int>("rating")
        let tracked = Expression<Bool>("tracked")
        let subskillId = Expression<Int>("subskillId")
        
        let db = Database().db
        let expertisesTable = Table("expertises")
        do {
            for expertise in try db.prepare(expertisesTable) {
                print((try expertise.get(name)) + String(try expertise.get(id)) + String(try expertise.get(tracked)))
            }
        } catch {
            fatalError("Failed to get list of expertises from database");
        }
        
    }
    
    static func getTrackedExpertises() -> [Expertise]{
        let id = Expression<Int>("id")
        let name = Expression<String>("name")
        let rating = Expression<Int>("rating")
        let tracked = Expression<Bool>("tracked")
        let subskillId = Expression<Int>("subskillId")
        
        
        let db = Database().db
        let expertisesTable = Table("expertises")
        var expertises = [Expertise]()
        let query = expertisesTable.filter(tracked == true)
        do {
            for expertise in try db.prepare(query) {
                    let exp = Expertise(id: try expertise.get(id),  name: try expertise.get(name), rating: try expertise.get(rating), tracked: try expertise.get(tracked), subskillId: try expertise.get(subskillId))
                    expertises.append(exp!)
            }
        } catch {
            fatalError("Failed to get instance of Expertise from database");
        }
        
        return expertises
        
    }
}
