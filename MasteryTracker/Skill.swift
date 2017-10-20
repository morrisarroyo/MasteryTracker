//
//  Skill.swift
//  MasteryTracker
//
//  Created by Morris Arroyo on 2017-10-20.
//  Copyright © 2017 BCIT. All rights reserved.
//

import UIKit

class Skill {
    var id: String
    var name : String
    var rating : Int
    var subskills : [Subskill]

    
    //Mark Initialization
    init?(id: String, name: String, rating: Int, subskills : [Subskill]) {
        
        guard !id.isEmpty else {
            return nil
        }
        
        // The name must not be empty
        guard !name.isEmpty else {
            return nil
        }
        
        // The rating must be between 0 and 5 inclusively
        guard (rating >= 0) && (rating <= 5) else {
            return nil
        }
        
        // The expertises array must not be empty
        guard !subskills.isEmpty else {
            return nil
        }
        
        self.id = id
        self.name = name
        self.rating = rating
        self.subskills = subskills
    }
}
