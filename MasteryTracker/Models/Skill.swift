//
//  Skill.swift
//  MasteryTracker
//
//  Created by Morris Arroyo on 2017-10-20.
//  Copyright © 2017 BCIT. All rights reserved.
//

import UIKit

class Skill {
    let tableName: String = "skills"
    var id: Int
    var name : String
    var rating : Int
    var subskills : [Subskill]
    var masteryId : Int = 1
    
    //Mark Initialization
    init?(id: Int, name: String, rating: Int, subskills : [Subskill]) {
        
        // The name must not be empty
        guard !name.isEmpty else {
            return nil
        }
        
        // The rating must be between 0 and 5 inclusively
        guard (rating >= 0) && (rating <= 5) else {
            return nil
        }
        
        self.id = id
        self.name = name
        self.rating = rating
        self.subskills = subskills
    }
}
