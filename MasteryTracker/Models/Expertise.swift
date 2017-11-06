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
    static let tableName: String = "expertises"
   
    static let minRating: Int = 0
    static let maxRating: Int = 5
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
        guard (rating >= Expertise.minRating) && (rating <= Expertise.maxRating) else {
            return nil
        }
        
        self.id = id
        self.name = name
        self.rating = rating
        self.tracked = tracked
        self.subskillId = subskillId
    }
    
    func toggleTracked() -> Bool {
        let db = Database().db
        let dbId = Expression<Int>("id")
        let dbTracked = Expression<Bool>("tracked")
        let expertisesTable = Table(Expertise.tableName)
        let expertise = expertisesTable.filter(dbId == id)
        do {
            if(try db.run(expertise.update(dbTracked <- !tracked)) > 0) {
                tracked = !tracked
            }
        } catch {
            print("failed to toggle expertise tracked")
        }
        return tracked
    }
    
    func incrementRating() -> Int {
        let temp = rating + 1;
        if(validateRating(rating: temp)) {
            let dbId = Expression<Int>("id")
            let dbRating = Expression<Int>("rating")
            let db = Database().db
            let expertisesTable = Table(Expertise.tableName)
            let expertise = expertisesTable.filter(dbId == id)
            do {
                if(try db.run(expertise.update(dbRating <- temp)) > 0) {
                    rating = temp
                }
            } catch {
                print("failed to increment expertise rating")
            }
        }
        return rating
    }
    
    func decrementRating() -> Int {
        let temp = rating - 1;
        if(validateRating(rating: temp)) {
            let dbId = Expression<Int>("id")
            let dbRating = Expression<Int>("rating")
            let db = Database().db
            let expertisesTable = Table(Expertise.tableName)
            let expertise = expertisesTable.filter(dbId == id)
            do {
                if(try db.run(expertise.update(dbRating <- temp)) > 0) {
                    rating = temp
                }
                print(rating)
            } catch {
                print("failed to increment expertise rating")
            }
        }
        return rating
    }
    
    func validateRating(rating: Int) -> Bool {
        return (rating >= Expertise.minRating && rating <= Expertise.maxRating)
    }
    static func getExpertisesForSubskill(num : Int) -> [Expertise]{
        let id = Expression<Int>("id")
        let name = Expression<String>("name")
        let rating = Expression<Int>("rating")
        let tracked = Expression<Bool>("tracked")
        let subskillId = Expression<Int>("subskillId")
        
        let db = Database().db
        let expertisesTable = Table(tableName)
        var expertises = [Expertise]()
        let query = expertisesTable.filter(subskillId == num)
        do {
            for expertise in try db.prepare(query) {
                let exp = Expertise(id: try expertise.get(id),  name: try expertise.get(name), rating: try expertise.get(rating), tracked: try expertise.get(tracked), subskillId: try expertise.get(subskillId))
                expertises.append(exp!)
            }
        } catch {
            print("Failed to get list of expertises from database");
        }
        return expertises
    }
    
    static func listExpertisesRows() {
        let id = Expression<Int>("id")
        let name = Expression<String>("name")
        //let rating = Expression<Int>("rating")
        let tracked = Expression<Bool>("tracked")
        //let subskillId = Expression<Int>("subskillId")
        
        let db = Database().db
        let expertisesTable = Table(tableName)
        do {
            for expertise in try db.prepare(expertisesTable) {
                print((try expertise.get(name)) + String(try expertise.get(id)) + String(try expertise.get(tracked)))
            }
        } catch {
            print("Failed to get list of expertises from database");
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
            print("Failed to get instance of Expertise from database");
        }
        
        return expertises
        
    }
}
