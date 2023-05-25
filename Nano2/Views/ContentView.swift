//
//  ContentView.swift
//  Nano2
//
//  Created by Daniel Widjaja on 16/05/23.
//

import SwiftUI
import HealthKit

struct ContentView: View {
    
    @Environment(\.scenePhase) var scenePhase
    
    var firstTime = UserDefaults.standard.bool(forKey: "firstTime")
    var CDM = CoreDataManager.shared
    
    var achCore = AchievementCoreDataManager()
    
    private var healthStore: HealthStore?
    
    @State var stepToday = Step(count: 0, date: Date())
    @State var stepYesterday = Step(count: 0, date: Date())
    
    var contentVM: ContentViewModel {
        return ContentViewModel(stepToday: $stepToday, stepYesterday: $stepYesterday)
    }
    
    @ObservedObject var monsterVM = MonsterViewModel()
    
    var todayMonster: MonsterModel?
    
    var achVM = AchievementViewModel()
    
    var achList: [Achievement] {
        achCore.getAllAchievements().sorted { $0.order < $1.order }
    }
    
    var isGoal: Bool {
        if contentVM.getRemainingSteps() == 0 {
            return true
        }
        return false
    }
    
    @State var showAchDetail = false
    @State var achDetailIndex = 0
    
    
    init() {
        if !firstTime {
            // First Time Open App
            CDM.freshRestart()
            CDM.save()
            UserDefaults.standard.set(true, forKey: "firstTime")
        }
        
        healthStore = HealthStore()
        contentVM.calculateStep(healthStore: healthStore)
        monsterVM.getTodayMonster(yesterdayStep: self.stepYesterday)
        if let decodedData = UserDefaults.standard.data(forKey: "todayMonster") {
            do {
                let decoder = PropertyListDecoder()
                let decodedMonster = try decoder.decode(MonsterModel.self, from: decodedData)
                
                todayMonster = decodedMonster
            } catch {
                print("Error: \(error)")
            }
        }
        achVM.checkAllAchievement()
    }
    
    var body: some View {
        ZStack {
            Color(UIColor(hexString: todayMonster?.lightColor ?? ""))
                .ignoresSafeArea(.all)
            
            ScrollView {
                
                VStack {
                    
                    // Monster
                    VStack {
                        
                        Text((isGoal ? "Congratulations" : todayMonster?.name) ?? "monster name")
                            .font(.title)
                            .foregroundColor(.white)
                            .bold()
                        
                        // Monster Image
                        if isGoal {
                            VStack (spacing: 0) {
                                Image(systemName: "trophy.fill")
                                    .font(.system(size: 150))
                                    .frame(width: 250, height: 300)
                                
                                Text("You have reach your daily step goals")
                                    .font(.title3)
                                    .multilineTextAlignment(.center)
                            }
                            .frame(maxWidth: 250)
                            .padding()
                            .background(.white)
                        } else {
                            Image(todayMonster?.imageName ?? "octomad")
                                .resizable()
                                .scaledToFit()
                                .frame(maxWidth: 280)
                                .padding()
                                .background(.white)
                        }
                        
                        // Health
                        ZStack {
                            ProgressBar(value: contentVM.getRemainingStepsPercentage())
                                .frame(width: 285, height: 45)
                            
                            VStack {
                                Text("\(contentVM.getRemainingSteps())")
                                    .font(.headline)
                                    .foregroundColor(.white)
                                Text("Steps remaining")
                                    .font(.caption2)
                                    .foregroundColor(.white)
                            }
                            
                        }
                        
                        
                    }
                    .padding()
                    .background(
                        Color(UIColor(hexString: todayMonster?.darkColor ?? "")).ignoresSafeArea(.all)
                    )
                    .cornerRadius(20)
                    
                    // Info Badges
                    HStack (alignment: .top, spacing: 0) {
                        Spacer()
                        InfoView(imageName: "info_step", description: "Do 10.000 steps to defeat the monster")
                        Spacer()
                        InfoView(imageName: "info_achievement", description: "Open app to collect achievement")
                        Spacer()
                    }
                    .padding()
                    
                    // Achievement
                    HStack {
                        Spacer()
                        
                        VStack (alignment: .center){
                            Text("Achievement")
                                .foregroundColor(.white)
                            
                            HStack (alignment: .top, spacing: 30){
                                ForEach (0..<3) {i in
                                    AchievementBadge(
                                        imageName: achList[i].imageName ?? "",
                                        name: achList[i].name ?? "",
                                        isEarned: achList[i].isEarned )
                                    .onTapGesture {
                                        achDetailIndex = i
                                        showAchDetail = true
                                    }
                                }
                            }
                            
                            HStack (alignment: .top, spacing: 30){
                                ForEach (3..<6) {i in
                                    AchievementBadge(
                                        imageName: achList[i].imageName ?? "",
                                        name: achList[i].name ?? "",
                                        isEarned: achList[i].isEarned )
                                    .onTapGesture {
                                        achDetailIndex = i
                                        showAchDetail = true
                                    }
                                }
                            }
                            
                            HStack (alignment: .top, spacing: 30){
                                ForEach (6..<9) {i in
                                    AchievementBadge(
                                        imageName: achList[i].imageName ?? "",
                                        name: achList[i].name ?? "",
                                        isEarned: achList[i].isEarned )
                                    .onTapGesture {
                                        achDetailIndex = i
                                        showAchDetail = true
                                    }
                                }
                            }
                            
                            HStack (alignment: .top, spacing: 30){
                                ForEach (9..<12) {i in
                                    AchievementBadge(
                                        imageName: achList[i].imageName ?? "",
                                        name: achList[i].name ?? "",
                                        isEarned: achList[i].isEarned )
                                    .onTapGesture {
                                        achDetailIndex = i
                                        showAchDetail = true
                                    }
                                }
                            }
                        }
                        .padding()
                        
                        Spacer()
                    }
                    .background(
                        Color(UIColor(hexString: todayMonster?.darkColor ?? "")).ignoresSafeArea(.all)
                    )
                    .cornerRadius(20)
                    .frame(maxWidth: 310)
                }
            }
            
            if showAchDetail {
                let ach = achList[achDetailIndex]
                
                AchievementBadgeDetail(
                    name: ach.name ?? "",
                    imageName: ach.imageName ?? "",
                    desc: ach.desc ?? "",
                    isEarned: ach.isEarned,
                    isShown: $showAchDetail
                )
                
            }
        }
        
        .onChange(of: scenePhase) { newPhase in
            if newPhase == .active {
                contentVM.calculateStep(healthStore: healthStore)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
