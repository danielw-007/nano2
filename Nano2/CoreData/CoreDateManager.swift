//
//  CoreDateManager.swift
//  Nano2
//
//  Created by Daniel Widjaja on 23/05/23.
//

import CoreData
import Foundation

class CoreDataManager: ObservableObject {
    let persistentContainer: NSPersistentContainer
    
    static let shared = CoreDataManager()
    
    var viewContext: NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    private init() {
        persistentContainer = NSPersistentContainer(name: "Model")
        persistentContainer.loadPersistentStores { _, error in
            if let error = error {
                fatalError("Unable to initialize Core Data Stack \(error)")
            }
        }
    }
    
    func freshRestart() {
        deleteAllEntity(entityName: "Achievement")
        deleteAllEntity(entityName: "User")
        
        AchievementCoreDataManager().seedAchievements()
        UserCoreDataManager().seedUser()
    }
    
    func deleteAllEntity(entityName: String) {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: entityName)
        let deleteReq = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try viewContext.execute(deleteReq)
        } catch let error as NSError {
            print(error)
        }
    }
    
    func save() {
        do {
            try viewContext.save()
        } catch {
            viewContext.rollback()
            print(error.localizedDescription)
        }
    }
}
