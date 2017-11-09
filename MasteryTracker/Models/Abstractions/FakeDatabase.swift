//
//  FakeDatabase.swift
//  MasteryTracker
//
//  Created by Morris Arroyo on 2017-10-20.
//  Copyright © 2017 BCIT. All rights reserved.
//
/*
import Foundation

class FakeDatabase {
    let database: [Skill]
    
    init() {
        //Skill 0 - Anatomy
        let expertise000 = Expertise(id: 0, name: "Facial Structure", rating: 2, tracked: true, subskillId: 0)
        let expertise001 = Expertise(id: 1, name:"Facial Muscles", rating: 1, tracked: true, subskillId: 0)
        let subskill00 = Subskill(id: 0, name: "Facial Anatomy", rating: 2, expertises: [expertise000!, expertise001!], skillId: 0)
        let expertise010 = Expertise(id: 2, name: "Torso Structure", rating: 1, tracked: true, subskillId: 1)
        let expertise011 = Expertise(id: 3,name: "Torso Muscles", rating: 2, tracked: false, subskillId: 1)
        let subskill01 = Subskill(id: 1, name: "Torso Anatomy", rating: 2, expertises: [expertise010!, expertise011!], skillId: 0)
        let skill0 = Skill(id: 0, name: "Anatomy", rating: 1, subskills: [subskill00!, subskill01!])
        //Skill 1 - Color
        //Skill 2 - Line Consistency
        //Skill 3 - Gesture
        //Skill 4 - Light and Shadow
        //Skill 5 - Realism
        //Skill 6 - Caricature
        //Skill 7 - Cartoon
        //Skill 8 - Action/Motion
        let expertise800 = Expertise(id: 4, name: "Running Weight Distribution", rating: 0, tracked: false, subskillId: 2)
        let expertise801 = Expertise(id: 5, name: "Receiving Attack Weight Distribution", rating: 0, tracked: false, subskillId: 2)
        let subskill80 = Subskill(id: 2, name: "Weight Distribution", rating: 0, expertises: [expertise800!, expertise801!], skillId: 1)
        let expertise810 = Expertise(id: 6, name: "Towards Screen Foreshortening", rating: 0, tracked: false, subskillId: 3)
        let expertise811 = Expertise(id: 7, name: "Away from Screen Foreshortening", rating: 0, tracked: false, subskillId: 3)
        let subskill81 = Subskill(id:3, name: "Foreshortening", rating: 0, expertises: [expertise810!, expertise811!], skillId: 1)
        let skill8 = Skill(id: 1, name:"Action/Motion", rating: 0, subskills: [subskill80!, subskill81!])
        //Skill 9 - Copying
        
        self.database = [skill0!, skill8!]
    }
    
    func getSkills() -> [Skill] {
        return database
    }
    
    func getSubskills( skillId : Int ) -> [Subskill] {
        
        var sk: Skill = database[0]
        database.forEach {
            skill in
            if(skill.id == skillId)
                { sk = skill }
        }
        return sk.subskills
        //fatalError("The skill id, \(skillId), is not a valid skillId")
    }
    
    func getExpertises( subskillId : Int ) -> [Expertise] {
        
        var sk: Subskill = database[0].subskills[0]
        database.forEach {
            skill in
            skill.subskills.forEach { subskill in
                if (subskill.id == subskillId){
                    sk = subskill
                }
            }
        }
        return sk.expertises
        //fatalError("The skill id, \(skillId), is not a valid skillId")
    }
}
*/
