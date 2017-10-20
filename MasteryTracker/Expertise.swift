//
//  Expertise.swift
//  
//
//  Created by Morris Arroyo on 2017-10-20.
//

import UIKit

class Expertise {
    
    //MARK: Properties
    var id: String
    var name: String
    var rating: Int
    var tracked: Bool
    var subskillId: String
    
    //MARK: Initialization
    init?(id: String, name: String, rating: Int, tracked: Bool = false, subskillId: String) {
        
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
        
        guard !subskillId.isEmpty else {
            return nil
        }
        
        self.id = id
        self.name = name
        self.rating = rating
        self.tracked = tracked
        self.subskillId = subskillId
    }
}
