//
//  TestTRackingData.swift
//  MasteryTracker
//
//  Created by Morris Arroyo on 2017-11-09.
//  Copyright © 2017 BCIT. All rights reserved.
//

import UIKit
import SQLite

class TestTrackingData: NSObject {
    func testFirstDayTrackingReportData() {
        let db = Database().db
        var ids = [Int]()
        // tables
        let tracked              = Table("tracked")
        let trackedDays          = Table("trackedDays")
        let trackedReports       = Table("trackedReports")
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
        let firstDay        = Expression<String>("firstDay")
        let history         = Expression<String>("history")
        let id = Expression<Int>("id")
        let trackedEx = Expression<Bool>("tracked")
        let expertises = Table("expertises")
        
        let query = expertises.filter(trackedEx == true)
        
        do {
            for row in try db.prepare(query) {
                ids.append(try row.get(expertises[id]))
            }
        } catch {
            print("testFirstDayTrackingReportData, Failed to prepare list of expertises from database")
        }
        for id in ids {
            let query = trackedReports.filter(trackingId == id)
            do {
                try db.run(query.update(firstDay <- DateFormatter().string(from:Calendar.current.date(byAdding: .day, value: -3, to:Date())!)))
            } catch let error {
                print("testFirstDayTrackingReportData, Failed update tracking report with id \(id): \(error)")
            }
        }
    }

}
