//
//  TrackedDay.swift
//  MasteryTracker
//
//  Created by Morris Arroyo on 2017-11-08.
//  Copyright © 2017 BCIT. All rights reserved.
//

import UIKit

class TrackedDay: NSObject {
    var dayOffset: Int
    var done: Bool
    var trackingId: Int
    
    init (dayOffset: Int, done: Bool, trackingId: Int) {
        self.dayOffset = dayOffset
        self.done = done
        self.trackingId = trackingId
    }
    
    static func getStreakFor(trackedDays: [TrackedDay]) -> Int {
        var streak = 0
        for day in trackedDays {
            if (day.done) {
                streak += 1
            } else {
                break
            }
        }
        return streak
    }
}
