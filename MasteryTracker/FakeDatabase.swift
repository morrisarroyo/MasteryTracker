//
//  FakeDatabase.swift
//  MasteryTracker
//
//  Created by Morris Arroyo on 2017-10-20.
//  Copyright © 2017 BCIT. All rights reserved.
//

import Foundation

class FakeDatabase {
    var database: [Skill]
    
    init() {
        //Skill 0 - Anatomy
        var expertise000 = Expertise(id: "000", name: "Facial Structure", rating: 2, tracked: true, subskillId: "00")
        var expertise001 = Expertise(id: "001", name:"Facial Muscles", rating: 1, tracked: true, subskillId: "00")
        var subskill00 = Subskill(id: "00", name: "Facial Anatomy", rating: 2, expertises: [expertise000!, expertise001!], skillId: "0")
        var expertise010 = Expertise(id: "010", name: "Torso Structure", rating: 1, tracked: true, subskillId: "01")
        var expertise011 = Expertise(id: "011",name: "Torso Muscles", rating: 2, tracked: false, subskillId: "01")
        var subskill01 = Subskill(id: "01", name: "Torso Anatomy", rating: 2, expertises: [expertise010!, expertise011!], skillId: "0")
        var skill0 = Skill(id: "0", name: "Anatomy", rating: 1, subskills: [subskill00!, subskill01!])
        //Skill 1 - Color
        //Skill 2 - Line Consistency
        //Skill 3 - Gesture
        //Skill 4 - Light and Shadow
        //Skill 5 - Realism
        //Skill 6 - Caricature
        //Skill 7 - Cartoon
        //Skill 8 - Action/Motion
        var expertise800 = Expertise(id: "800", name: "Running Weight Distribution", rating: 0, tracked: false, subskillId: "80")
        var expertise801 = Expertise(id: "801", name: "Receiving Attack Weight Distribution", rating: 0, tracked: false, subskillId: "80")
        var subskill80 = Subskill(id: "80", name: "Weight Distribution", rating: 0, expertises: [expertise800!, expertise801!], skillId: "8")
        var expertise810 = Expertise(id: "810", name: "Towards Screen Foreshortening", rating: 0, tracked: false, subskillId: "81")
        var expertise811 = Expertise(id: "811", name: "Away from Screen Foreshortening", rating: 0, tracked: false, subskillId: "81")
        var subskill81 = Subskill(id:"81", name: "Foreshortening", rating: 0, expertises: [expertise810!, expertise811!], skillId: "8")
        var skill8 = Skill(id: "8", name:"Action/Motion", rating: 0, subskills: [subskill80!, subskill81!])
        //Skill 9 - Copying
        
        self.database = [skill0!, skill8!]
    }
    
    func getSkills() -> [Skill] {
        return database
    }
    
    func getSubskills( skillId : String ) -> [Subskill] {
        guard !skillId.isEmpty else {
            fatalError("The skill id, \(skillId), is empty")
        }
        var sk: Skill = database[0]
        database.forEach {
            skill in
            if(skill.id == skillId)
                { sk = skill }
        }
        return sk.subskills
        //fatalError("The skill id, \(skillId), is not a valid skillId")
    }
    
    func getExpertises( subskillId : String ) -> [Expertise] {
        guard !subskillId.isEmpty else {
            fatalError("The skill id, \(subskillId), is empty")
        }
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
