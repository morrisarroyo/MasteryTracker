//
//  Criteria.swift
//  MasteryTracker
//
//  Created by Morris Arroyo on 2017-11-03.
//  Copyright © 2017 BCIT. All rights reserved.
//

import UIKit
import SQLite
enum CriteriaType: Int {
    case mastery, skill, subskill, expertise
}

class Criteria: NSObject {
    static let tableName: String = "criterias"
    static let typeTableName: String = "criteriaTypes"
    var id: Int
    var rating: Int
    var name: String
    var desc: String
    var typeId: Int
    
    init?(id:Int, rating:Int, name:String, desc:String, typeId:Int) {
        // The rating must be between 0 and 5 inclusively
        guard (rating >= 0) && (rating <= 5) else {
            return nil
        }
        
        // The name must not be empty
        guard !name.isEmpty else {
            return nil
        }
        
        guard !desc.isEmpty else {
            return nil
        }
        
        // The rating must be between 0 and 5 inclusively
        guard (rating >= 0) && (rating <= 3) else {
            return nil
        }
        
        self.id = id
        self.rating = rating
        self.name = name
        self.desc = desc
        self.typeId = typeId
    }
    static func listCriteriasRows() {
        let id = Expression<Int>("id")
        let rating = Expression<Int>("rating")
        let name = Expression<String>("name")
        let desc = Expression<String>("description")
        let typeId = Expression<Int>("typeId")
        
        let db = Database().db
        let criteriasTable = Table(tableName)
        do {
            for criteria in try db.prepare(criteriasTable) {
                print("id: \(try criteria.get(id)), rating: \(try criteria.get(rating)),  name: \(try criteria.get(name)), desc: \(try criteria.get(desc)),typeId: \(try criteria.get(typeId))")
            }
        } catch {
            print("Failed to list criterias from database");
        }
    }
    
    static func getCriteriaForType(type : CriteriaType) -> [Criteria]{
        let id = Expression<Int>("id")
        let rating = Expression<Int>("rating")
        let name = Expression<String>("name")
        let desc = Expression<String>("description")
        let typeId = Expression<Int>("typeId")
        
        let db = Database().db
        let criteriasTable = Table(tableName)
        var criterias = [Criteria]()
        let query = criteriasTable.filter(typeId == type.rawValue)
        do {
            for criteria in try db.prepare(query) {
                let cri = Criteria(id: try criteria.get(id), rating: try criteria.get(rating),  name: try criteria.get(name), desc: try criteria.get(desc),typeId: try criteria.get(typeId))
                criterias.append(cri!)
            }
        } catch {
            print("Failed to get list of criterias from database");
        }
        return criterias
    }
}
