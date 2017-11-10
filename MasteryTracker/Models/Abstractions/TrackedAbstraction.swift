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
    static let trackedTableName        = "tracked"
    static let trackedDaysTableName    = "trackedDays"
    static let trackedReportsTableName = "trackedReports"
    // tables
    let tracked              = Table(trackedTableName)
    let trackedDays          = Table(trackedDaysTableName)
    let trackedReports       = Table(trackedReportsTableName)
    // trackedExpertises columns
    let trackedId            = Expression<Int>("id")
    let typeId               = Expression<Int>("typeId")
    let objectId             = Expression<Int>("objectId")
    // trackedDays columns
    let dayOffset       = Expression<Int>("dayOffset")
    let done            = Expression<Bool>("done")
    let trackingId      = Expression<Int>("trackingId")
    // trackedReport columns
    let reportId = Expression<Int>("id")
    let currentStreak = Expression<Int>("currentStreak")
    let longestStreak = Expression<Int>("longestStreak")
    let daysSinceFirst = Expression<Int>("daysSinceFirst")
    let history = Expression<String>("history")
    //
    let daysCount: Int
    init(daysCount: Int) {
        self.daysCount = daysCount
    }
    
    convenience init () {
        self.init(daysCount: 7)
    }
    
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
                    ,trackingId: try day.get(trackingId)
                )
                days.append(trackedDay)
            }
        } catch {
            print("Failed to get list of tracked days from database of expertise id \(id)")
        }
        return days
    }
    
    /*
     *  can seperated into 3 functions
     *      createTrackedForExpertise(id: Int) -> trackedId value : Int
     *      createTrackedDaysForTracked(id: Int) -> days created : Int
     *      createTrackedReportForTracked(id: Int) -> trackedReportId value : Int
     */
    func createTrackingForExpertise(id: Int) -> Int {
        let db = Database().db
        do {
            try db.run(tracked.insert(or: .ignore, typeId <- CriteriaType.expertise.rawValue, objectId <- id))
        } catch let error {
            print("createTrackingForExpertise tracked table insertion error for id \(id): \(error)")
        }
        let trackedIdQuery = tracked.filter(typeId == CriteriaType.expertise.rawValue && objectId == id)
        var trackedIdValue: Int = -1
        do {
            if let tr = try db.pluck(trackedIdQuery) {
                trackedIdValue = try tr.get(trackedId)
            }
        } catch let error {
            print("createTrackingForExpertise tracked table query error for id \(id): \(error)")
        }
        for d in 0..<daysCount { // d is dayOffset value
            do {
                try db.run(trackedDays.insert(or: .ignore, dayOffset <- d, done <- false, trackingId <- trackedIdValue))
            } catch let error {
                print("createTrackingForExpertise trackedDays table insertion error for id \(id) and dayOffset \(d): \(error)")
            }
        }
        do {
            try db.run(trackedReports.insert(or: .ignore, currentStreak <- 0, longestStreak <- 0, daysSinceFirst <- 0, history <- "", trackingId <- trackedIdValue))
        } catch let error {
            print("createTrackingForExpertise trackedReports table insertion error for id \(id): \(error)")
        }
        return trackedIdValue
    }
    
    func updateTrackedDay(_ trackedDay: TrackedDay) {
        let db = Database().db
        let query = trackedDays.filter(dayOffset == trackedDay.dayOffset && trackingId == trackedDay.trackingId)
        do {
            try db.run(query.update(done <- trackedDay.done))
        } catch let error {
            print("updateTrackedDay, tracked day of trackingId \(trackedDay.trackingId) and dayOffset of \(trackedDay.dayOffset) doesn't exist")
            print("updateTrackedDay, trackedDays table query error for trackingId \(trackedDay.trackingId): \(error)")
        }
    }
    
    func updateTrackedReport(_ trackedReport: TrackedReport) {
        let db = Database().db
        let query = trackedReports.filter(trackingId == trackedReport.trackingId)
        do {
            try db.run(query.update(currentStreak <- trackedReport.currentStreak, longestStreak <- trackedReport.longestStreak, daysSinceFirst <- trackedReport.daysSinceFirst, history <- trackedReport.history))
        } catch let error {
            print("updateTrackedReport, tracked report of trackingId \(trackedReport.trackingId) doesn't exist")
            print("updateTrackedReport trackedReports table query error for trackingId \(trackedReport.trackingId): \(error)")
        }
    }
}

