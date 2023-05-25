//
//  MonsterViewModel.swift
//  Nano2
//
//  Created by Daniel Widjaja on 23/05/23.
//

import Foundation
import SwiftUI

class MonsterViewModel: ObservableObject {
    
    @Published var monsterList = [MonsterModel]()
    
    var todayMonster: MonsterModel?
    
    var userCDM = UserCoreDataManager()
    var user: User?
    
    init() {
        
        user = userCDM.getUser() ?? nil
        
        let octomad = MonsterModel(name: "Octomad", imageName: "octomad", lightColor: Color.monsterLightGreen, darkColor: Color.monsterDarkGreen)
        let gargantuan = MonsterModel(name: "Gargantuan", imageName: "gargantuan", lightColor: Color.monsterLightPurple, darkColor: Color.monsterDarkPurple)
        let hammerhead = MonsterModel(name: "Hammerhead", imageName: "hammerhead", lightColor: Color.monsterLightBlue, darkColor: Color.monsterDarkBlue)
        monsterList.append(octomad)
        monsterList.append(gargantuan)
        monsterList.append(hammerhead)
        
        if let decodedData = UserDefaults.standard.data(forKey: "todayMonster") {
            do {
                let decoder = PropertyListDecoder()
                let decodedMonster = try decoder.decode(MonsterModel.self, from: decodedData)
                
                todayMonster = decodedMonster
            } catch {
                print("Error: \(error)")
            }
        }
    }
    
    func getTodayMonster(yesterdayStep: Step) {
        self.getRandomMonster()
        if let fetchDate = UserDefaults.standard.object(forKey: "monsterFetch") as? Date {
            print("Date not empty")
            if !Calendar.current.isDateInToday(fetchDate) {
                
                // first for every day
                self.user?.lifetimeSteps += Int32(yesterdayStep.count)
                
                if Int32(yesterdayStep.count) >= 10000 {
                    self.user?.monsterDefeated += 1
                    
                    switch self.todayMonster?.name {
                    case "Octomad":
                        self.user?.octomadDefeated += 1
                    case "Gargantuan":
                        self.user?.gargantuanDefeated += 1
                    case "Hammerhead":
                        self.user?.hammerheadDefeated += 1
                    default:
                        print("error")
                    }
                }
                
                self.userCDM.coreDataManager.save()
                
                print("date is not today")
                self.getRandomMonster()
            }
        } else {
            // first time
            print("fetch date empty")
            self.getRandomMonster()
        }
    }
    
    
    func getRandomMonster() {
        UserDefaults.standard.set(Date(), forKey: "monsterFetch")
        let randomInt = Int.random(in: 0..<self.monsterList.count)
        
        do {
            let encoder = PropertyListEncoder()
            let encodedData = try encoder.encode(self.monsterList[randomInt])

            UserDefaults.standard.set(encodedData, forKey: "todayMonster")
        } catch {
            print("Error: \(error)")
        }
    }
}
