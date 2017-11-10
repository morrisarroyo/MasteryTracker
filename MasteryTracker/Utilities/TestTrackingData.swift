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
        
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        var count = 0
        var date = NSDate()
        do {
            count = try db.scalar(table.count)
        } catch {
            print("testFirstDayTrackingReportData, Failed query on trackingReports table")
        }
        
        do {
            
            print("\(count) \(date.description) ")
            
            //let query = table.filter(trackingId == id)
            for id in 0..<count {
                let query = table.filter(trackingId == id)
                try db.run(query.update(firstDay <- date.description))
                date = NSCalendar.current.date(byAdding: .day, value: -1, to: date as Date)! as NSDate
            }
        } catch let error {
            print("testFirstDayTrackingReportData, Failed update tracking reports: \(error)")
        }
    }

}
