//
//  AchievementViewModel.swift
//  Nano2
//
//  Created by Daniel Widjaja on 24/05/23.
//

import Foundation

class AchievementViewModel {
    
    var achCDM = AchievementCoreDataManager()
    var userCDM = UserCoreDataManager()
    
    var allCurrentAch: [Achievement] {
        return achCDM.getAllAchievements()
    }
    
    var user: User? {
        return userCDM.getUser()
    }
    
    // turned all not reached achievement into reached when conditions are met
    func checkAllAchievement() {
        
        let filteredAch = allCurrentAch.filter( {$0.isEarned == false} )
        
        for i in filteredAch {
            
            switch i.name {
            case "Knight Reborn":
                if user?.monsterDefeated ?? 0 >= 1 {
                    achCDM.earnAchievement(achievementName: i.name!)
                }
            case "Monster Slayer":
                if user?.monsterDefeated ?? 0 >= 10 {
                    achCDM.earnAchievement(achievementName: i.name!)
                }
            case "Stepvolution":
                if user?.monsterDefeated ?? 0 >= 100 {
                    achCDM.earnAchievement(achievementName: i.name!)
                }
            case "Octomad Hunter":
                if user?.octomadDefeated ?? 0 >= 1 {
                    achCDM.earnAchievement(achievementName: i.name!)
                }
            case "Octomad Slayer":
                if user?.octomadDefeated ?? 0 >= 10 {
                    achCDM.earnAchievement(achievementName: i.name!)
                }
            case "Gargantuan Hunter":
                if user?.gargantuanDefeated ?? 0 >= 1 {
                    achCDM.earnAchievement(achievementName: i.name!)
                }
            case "Gargantuan Slayer":
                if user?.gargantuanDefeated ?? 0 >= 10 {
                    achCDM.earnAchievement(achievementName: i.name!)
                }
            case "Hammerhead Hunter":
                if user?.hammerheadDefeated ?? 0 >= 1 {
                    achCDM.earnAchievement(achievementName: i.name!)
                }
            case "Hammerhead Slayer":
                if user?.hammerheadDefeated ?? 0 >= 10 {
                    achCDM.earnAchievement(achievementName: i.name!)
                }
            case "Step Olympiad":
                if user?.lifetimeSteps ?? 0 >= 100000 {
                    achCDM.earnAchievement(achievementName: i.name!)
                }
            case "Step-Tactular":
                if user?.lifetimeSteps ?? 0 >= 1000000 {
                    achCDM.earnAchievement(achievementName: i.name!)
                }
            default:
                print("error")
            }
        }
    }
    
}
