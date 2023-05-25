//
//  UserCoreDataManager.swift
//  Nano2
//
//  Created by Daniel Widjaja on 24/05/23.
//
import CoreData
import Foundation

class UserCoreDataManager {
    let coreDataManager = CoreDataManager.shared
    
    let viewContext = CoreDataManager.shared.viewContext
    
    func updateUserStatus(octo: Int32, garg: Int32, hammer: Int32, monster: Int32, steps: Int32) {
        let request: NSFetchRequest<User>
        request = User.fetchRequest()
        
        var user: User
        
        do {
            user = try viewContext.fetch(request).first!
            
            user.octomadDefeated = octo
            user.gargantuanDefeated = garg
            user.hammerheadDefeated = hammer
            user.monsterDefeated = monster
            user.lifetimeSteps = steps
            
            coreDataManager.save()
            print("Success update user")
        } catch {
            print("failed to fetch user")
            return
        }
    }
    
    func getUser() -> User? {
        let request: NSFetchRequest<User> = User.fetchRequest()
        do {
            return try coreDataManager.viewContext.fetch(request).first ?? nil
        } catch {
            print("failed to fetch user")
        }
        return nil
    }
    
    func seedUser() {
        guard let userEntity = NSEntityDescription.entity(forEntityName: "User", in: viewContext) else {
            return
        }
        
        let user = User(entity: userEntity, insertInto: viewContext)
        user.octomadDefeated = 0
        user.gargantuanDefeated = 0
        user.hammerheadDefeated = 0
        user.lifetimeSteps = 0
        user.monsterDefeated = 0
        
        coreDataManager.save()
    }
}
