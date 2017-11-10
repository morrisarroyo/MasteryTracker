//
//  TrackingReport.swift
//  MasteryTracker
//
//  Created by Morris Arroyo on 2017-11-08.
//  Copyright © 2017 BCIT. All rights reserved.
//

import UIKit

class TrackedReport: NSObject {
    var reportId        : Int
    var currentStreak   : Int
    var longestStreak   : Int
    var firstDay        : String
    var history         : String
    var trackingId      : Int
    
    init (  reportId        : Int
            ,currentStreak  : Int
            ,longestStreak  : Int
            ,firstDay       : String
            ,history        : String
            ,trackingId     : Int) {
        self.reportId       = reportId
        self.currentStreak  = currentStreak
        self.longestStreak  = longestStreak
        self.firstDay       = firstDay
        self.history        = history
        self.trackingId     = trackingId
    }
}
