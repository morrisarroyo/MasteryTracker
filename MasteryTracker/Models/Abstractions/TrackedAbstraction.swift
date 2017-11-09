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
 * TrackedAbstraction class.
 *
 * Provides access to tracked table
 * and trackedDays table.
 */
class TrackedAbstraction {
    static let trackedTableName      = "tracked"
    static let trackedDaysTableName  = "trackedDays"
    // tables
    let tracked              = Table(trackedTableName)
    let trackedDays          = Table(trackedDaysTableName)
    // trackedExpertises columns
    let trackedId            = Expression<Int>("id")
    let typeId               = Expression<Int>("typeId")
    let objectId             = Expression<Int>("objectId")
    // trackedDays columns
    let dayOffset       = Expression<Int>("dayOffset")
    let done            = Expression<Bool>("done")
    let trackingId      = Expression<Int>("trackingId")
    
    func getTrackedDaysForExpertise(id: Int) -> [TrackedDay]{
        var days: [TrackedDay] = []
        let db = Database().db
        let joined = tracked.join(trackedDays, on: trackedId == trackingId)
        let query = joined.filter(joined[typeId] == CriteriaType.expertise.rawValue && joined[objectId] == id)
        do {
            for day in try db.prepare(query) {
                let trackedDay = TrackedDay(
                    dayOffset: try day.get(dayOffset)
                    ,done:     try day.get(done)
                    ,objectId: try day.get(objectId)
                    ,typeId:   try day.get(typeId)
                )
                days.append(trackedDay)
            }
        } catch {
            print("Failed to get list of tracked days from database of expertise id \(id)")
        }
        return days
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

