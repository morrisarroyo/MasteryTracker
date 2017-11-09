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
    var objectId: Int
    var typeId: Int
    
    init (dayOffset: Int, done: Bool, objectId: Int, typeId: Int) {
        self.dayOffset = dayOffset
        self.done = done
        self.objectId = objectId
        self.typeId = typeId
    }
}
