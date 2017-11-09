//
//  TrackedExpertiseAbstraction.swift
//  MasteryTracker
//
//  Created by Morris Arroyo on 2017-11-08.
//  Copyright © 2017 BCIT. All rights reserved.
//

import Foundation
import SQLite

/*
 * TrackedExpertiseAbstraction class.
 *
 * Provides access to trackedExpertises table
 * and trackedDays table.
 */
class TrackedExpertiseAbstraction {
    static let trackedExpertisesTableName = "trackedExpertises"
    static let trackedDaysTableName       = "trackedDays"
    // tables
    let trackedExpertises    = Table(trackedExpertisesTableName)
    let trackedDays          = Table(trackedDaysTableName)
    // trackedExpertises columns
    let teId              = Expression<Int>("id")
    let expertiseId     = Expression<Int>("expertiseId")
    // trackedDays columns
    let dayOffset       = Expression<Int>("dayOffset")
    let done            = Expression<Bool>("done")
    let trackingId      = Expression<Int>("trackingId")
    
    func getTrackedDaysForExpertise(id: Int) -> [TrackedDay]{
        let db = Database().db
        /*
         let query = expertisesTable.filter(subskillId == num)
         do {
         for expertise in try db.prepare(query) {
         let exp = Expertise(id: try expertise.get(id),  name: try expertise.get(name), rating: try expertise.get(rating), tracked: try expertise.get(tracked), subskillId: try expertise.get(subskillId))
         expertises.append(exp!)
         }
         } catch {
         print("Failed to get list of expertises from database");
         }
         return expertises*/
        return []
    }
    /*
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
     
     }*/
}

