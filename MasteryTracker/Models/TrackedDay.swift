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
}
