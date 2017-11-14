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
    let reportId        = Expression<Int>("id")
    let currentStreak   = Expression<Int>("currentStreak")
    let longestStreak   = Expression<Int>("longestStreak")
    let total           = Expression<Int>("total")
    let firstDay        = Expression<String>("firstDay")
    let history         = Expression<String>("history")
    //
    let daysCount: Int
    init(daysCount: Int) {
        self.daysCount = daysCount
    }
    
    convenience init () {
        self.init(daysCount: 7)
    }
    
    func getTrackedReportsForTrackedExpertises() -> [TrackedReport] {
        var reports: [TrackedReport] = []
        let db = Database().db
        let expertise = Table("expertises")
        let expId = Expression<Int>("id")
        let expTracked = Expression<Bool>("tracked")
        let expertiseTracked = expertise.join(tracked, on: objectId == expertise[expId] && typeId == CriteriaType.expertise.rawValue)
        let expertiseTrackedReports = expertiseTracked.join(expertiseTracked, on: trackingId == tracked[trackedId])
        let query = expertiseTrackedReports.filter(expTracked == true)
        do {
            for report in try db.prepare(query) {
                let trackedReport = TrackedReport(
                    reportId:       try report.get(trackedReports[reportId])
                    ,currentStreak: try report.get(currentStreak)
                    ,longestStreak: try report.get(longestStreak)
                    ,total:         try report.get(total)
                    ,firstDay:      try report.get(firstDay)
                    ,history:       try report.get(history)
                    ,trackingId:    try report.get(self.trackingId))
                reports.append(trackedReport)
            }
        } catch {
            print("Failed to get list of tracked expertises from tracked reports table")
        }
        return reports
    }
    
    func getTrackedReport(trackingId: Int) -> TrackedReport? {
        var trackedReport: TrackedReport?
        let db = Database().db
        let query = trackedReports.filter(self.trackingId == trackingId)
        do {
            if let tr = try db.pluck(query) {
                trackedReport = TrackedReport(
                    reportId:       try tr.get(trackedReports[reportId])
                    ,currentStreak: try tr.get(currentStreak)
                    ,longestStreak: try tr.get(longestStreak)
                    ,total:         try tr.get(total)
                    ,firstDay:      try tr.get(firstDay)
                    ,history:       try tr.get(history)
                    ,trackingId:    try tr.get(self.trackingId))
            } else {
                print("getTrackedReport, tracked report of trackingId \(trackingId) doesn't exist")
                return nil
            }
        } catch let error {
            print("getTrackedReport trackedReports table query error for trackingId \(trackingId): \(error)")
        }
        return trackedReport
    }
    
    func getTrackedReportForExpertise(id: Int) -> TrackedReport? {
        var trackedReport: TrackedReport?
        let db = Database().db
        let joined = tracked.join(trackedReports, on: trackingId == tracked[trackedId])
        let query = joined.filter(joined[typeId] == CriteriaType.expertise.rawValue && joined[objectId] == id)
        do {
            if let tr = try db.pluck(query) {
                trackedReport = TrackedReport(
                     reportId:      try tr.get(trackedReports[reportId])
                    ,currentStreak: try tr.get(currentStreak)
                    ,longestStreak: try tr.get(longestStreak)
                    ,total:         try tr.get(total)
                    ,firstDay:      try tr.get(firstDay)
                    ,history:       try tr.get(history)
                    ,trackingId:    try tr.get(trackingId))
            } else {
                print("getTrackedReportForExpertise, tracked report of expertiseId \(id) doesn't exist")
                return nil
            }
        } catch let error {
            print("getTrackedReportForExpertise, trackedReports table query error for expertiseId \(id): \(error)")
        }
        return trackedReport
    }
    
    func getTrackedDaysForExpertise(id: Int) -> [TrackedDay]{
        var days: [TrackedDay] = []
        let db = Database().db
        let joined = tracked.join(trackedDays, on: trackingId == tracked[trackedId])
        var query = joined.filter(joined[typeId] == CriteriaType.expertise.rawValue && joined[objectId] == id)
        query = query.order(dayOffset.asc)
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
    func createTrackingForExpertise(id: Int) -> Int? {
        let db = Database().db
        do {
            try db.run(tracked.insert(or: .ignore, typeId <- CriteriaType.expertise.rawValue, objectId <- id))
        } catch let error {
            print("createTrackingForExpertise tracked table insertion error for id \(id): \(error)")
            return nil
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
            try db.run(trackedReports.insert(or: .ignore, currentStreak <- 0, longestStreak <- 0, total <- 0, firstDay <- "", history <- "", trackingId <- trackedIdValue))
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
            try db.run(query.update(currentStreak <- trackedReport.currentStreak, longestStreak <- trackedReport.longestStreak, total <- trackedReport.total, firstDay <- trackedReport.firstDay, history <- trackedReport.history))
        } catch let error {
            print("updateTrackedReport, tracked report of trackingId \(trackedReport.trackingId) doesn't exist")
            print("updateTrackedReport trackedReports table query error for trackingId \(trackedReport.trackingId): \(error)")
        }
    }
}

