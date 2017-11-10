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
        let table = Table("trackedReports")
        let trackingId = Expression<Int>("trackingId")
        let firstDay = Expression<String>("firstDay")
        
        var count = 0
        do {
            count = try db.scalar(table.count)
        } catch {
            print("testFirstDayTrackingReportData, Failed query on trackingReports table")
        }
        
        var date = NSDate()
        let df = DateFormatter()
        df.dateFormat = "YYYY-MM-dd"
        //let query = table.filter(trackingId == id)
        for id in 0..<count {
            let dateStr = df.string(from: date as Date)
            let query = table.filter(trackingId == id)
            do {
                try db.run(query.update(firstDay <- dateStr))
            } catch  {
                print("testFirstDayTrackingReportData, Failed update tracking reports: trackingId \(id)")
            }
            date = NSCalendar.current.date(byAdding: .day, value: -1, to: date as Date)! as NSDate
        }
    }
}
