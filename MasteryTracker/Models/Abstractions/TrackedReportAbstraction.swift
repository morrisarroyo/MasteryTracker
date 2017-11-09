//
//  TrackingReportAbstraction.swift
//  MasteryTracker
//
//  Created by Morris Arroyo on 2017-11-08.
//  Copyright © 2017 BCIT. All rights reserved.
//

import Foundation
import SQLite

class TrackingReportAbstraction {
    static let tableName = "trackedReports"
    let table =  Table(tableName)
    let id = Expression<Int>("id")
    let currentStreak = Expression<Int>("currentStreak")
    let longestStreak = Expression<Int>("longestStreak")
    let daysSinceFirst = Expression<Int>("daysSinceFirst")
    let history = Expression<String>("history")
    let expertiseId  = Expression<Int>("expertiseId")
    let typeId = Expression<Int>("typeId")
    /*
    let trackingReports = Table("trackingReports")
    do {
    try db.run(trackingReports.create(ifNotExists: true) { t in
    t.column(id, primaryKey: .autoincrement)
    t.column(currentStreak)
    t.column(longestStreak)
    t.column(daysSinceFirst)
    t.column(history)
    t.column(expertiseId)
    t.unique(expertiseId)
    })
    } catch {*/
}

