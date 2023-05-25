//
//  AchievementController.swift
//  Nano2
//
//  Created by Daniel Widjaja on 23/05/23.
//

import CoreData
import Foundation

class AchievementCoreDataManager {
    let coreDataManager = CoreDataManager.shared
    
    let viewContext = CoreDataManager.shared.viewContext
    
    func earnAchievement(achievementName: String) {
        let request: NSFetchRequest<Achievement>
        request = Achievement.fetchRequest()
        request.predicate = NSPredicate(format: "name LIKE %@", achievementName)
        
        var achievement: Achievement
        
        do {
            achievement = try viewContext.fetch(request).first!
            
            if !achievement.isEarned {
                achievement.isEarned = true
                coreDataManager.save()
                print("success update achievement!")
            } else {
                print("Achievement: \(achievementName) have been earned before")
            }
        } catch {
            print("failed to fetch achievement: \(achievementName)")
            return
        }
    }
    
    func getAllAchievements() -> [Achievement] {
        let request: NSFetchRequest<Achievement> = Achievement.fetchRequest()
        do {
            return try viewContext.fetch(request)
        } catch {
            print("failed to get all achievements")
        }
        return []
    }
    
    func seedAchievements() {
        guard let achievementEntity = NSEntityDescription.entity(forEntityName: "Achievement", in: viewContext) else {
            return
        }
        
        let ach0 = Achievement(entity: achievementEntity, insertInto: viewContext)
        ach0.name = "First Step"
        ach0.desc = "A journey of a thousand miles begins with a single step"
        ach0.imageName = "badges_step"
        ach0.order = 1
        ach0.isEarned = true
        
        let ach1 = Achievement(entity: achievementEntity, insertInto: viewContext)
        ach1.name = "Knight Reborn"
        ach1.desc = "Defeat your first monster"
        ach1.imageName = "knight_reborn"
        ach1.order = 2
        ach1.isEarned = false
        
        let ach2 = Achievement(entity: achievementEntity, insertInto: viewContext)
        ach2.name = "Monster Slayer"
        ach2.desc = "Defeat 10 monsters"
        ach2.imageName = "monster_slayer"
        ach2.order = 3
        ach2.isEarned = false
        
        let ach3 = Achievement(entity: achievementEntity, insertInto: viewContext)
        ach3.name = "Stepvolution"
        ach3.desc = "Defeat 100 monsters"
        ach3.imageName = "stepvolution"
        ach3.order = 4
        ach3.isEarned = false
        
        let ach4 = Achievement(entity: achievementEntity, insertInto: viewContext)
        ach4.name = "Octomad Hunter"
        ach4.desc = "Defeat 1 Octomad"
        ach4.imageName = "octomad_hunter"
        ach4.order = 5
        ach4.isEarned = false
        
        let ach5 = Achievement(entity: achievementEntity, insertInto: viewContext)
        ach5.name = "Octomad Slayer"
        ach5.desc = "Defeat 10 Octomad"
        ach5.imageName = "octomad_slayer"
        ach5.order = 6
        ach5.isEarned = false
        
        let ach6 = Achievement(entity: achievementEntity, insertInto: viewContext)
        ach6.name = "Gargantuan Hunter"
        ach6.desc = "Defeat 1 Gargantuan"
        ach6.imageName = "gargantuan_hunter"
        ach6.order = 7
        ach6.isEarned = false
        
        let ach7 = Achievement(entity: achievementEntity, insertInto: viewContext)
        ach7.name = "Gargantuan Slayer"
        ach7.desc = "Defeat 10 Gargantuan"
        ach7.imageName = "gargantuan_slayer"
        ach7.order = 8
        ach7.isEarned = false
        
        let ach8 = Achievement(entity: achievementEntity, insertInto: viewContext)
        ach8.name = "Hammerhead Hunter"
        ach8.desc = "Defeat 1 Hammerhead"
        ach8.imageName = "hammerhead_hunter"
        ach8.order = 9
        ach8.isEarned = false
        
        let ach9 = Achievement(entity: achievementEntity, insertInto: viewContext)
        ach9.name = "Hammerhead Slayer"
        ach9.desc = "Defeat 10 Hammerhead"
        ach9.imageName = "hammerhead_slayer"
        ach9.order = 10
        ach9.isEarned = false
        
        let ach10 = Achievement(entity: achievementEntity, insertInto: viewContext)
        ach10.name = "Step Olympiad"
        ach10.desc = "Reach 100.000 steps"
        ach10.imageName = "step_olympiad"
        ach10.order = 11
        ach10.isEarned = false
        
        let ach11 = Achievement(entity: achievementEntity, insertInto: viewContext)
        ach11.name = "Step-Tactular"
        ach11.desc = "Reach 1.000.000 steps"
        ach11.imageName = "step-tacular"
        ach11.order = 12
        ach11.isEarned = false
        
        coreDataManager.save()
    }
}
