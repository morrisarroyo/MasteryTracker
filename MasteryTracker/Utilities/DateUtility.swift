//
//  DateUtility.swift
//  MasteryTracker
//
//  Created by Morris Arroyo on 2017-11-09.
//  Copyright © 2017 BCIT. All rights reserved.
//

import Foundation

class DateUtility {
    static func daysDifferenceForDates(from: Date, to: Date) -> Int {
        let calendar = NSCalendar.current
        
        // Replace the hour (time) of both dates with 00:00
        let date1 = calendar.startOfDay(for: from)
        let date2 = calendar.startOfDay(for: to)
        
        let components = calendar.dateComponents([.day], from: date1, to: date2)
        
        return components.day!// This will return the number of day(s) between dates
    }
}
