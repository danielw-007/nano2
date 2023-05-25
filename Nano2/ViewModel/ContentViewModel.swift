//
//  ContentViewModel.swift
//  Nano2
//
//  Created by Daniel Widjaja on 22/05/23.
//

import Foundation
import SwiftUI
import HealthKit

struct ContentViewModel {
    
    @Binding var stepToday: Step
    @Binding var stepYesterday: Step
    
    func calculateStep(healthStore: HealthStore?) {
        if let healthStore = healthStore {
            healthStore.requestAuthorization { success in
                if success {
                    healthStore.calculateSteps { statisticsCollection in
                        if let statisticsCollection = statisticsCollection {
                            // update the UI
                            updateUIFromStatistics(statisticsCollection)
                        }
                    }
                }
            }
        }
    }
    
    func updateUIFromStatistics(_ statisticsCollection: HKStatisticsCollection) {
        // Today Steps
        let startOfDay = Calendar.current.startOfDay(for: Date())
        let endDate = Date()
        
        statisticsCollection.enumerateStatistics(from: startOfDay, to: endDate) { (statistics, stop) in
            let count = statistics.sumQuantity()?.doubleValue(for: .count())
            
            var step = Step(count: Int(count ?? 0), date: statistics.startDate)
            stepToday.count = step.count
        }
        
        // Yesterday Steps
        let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: Date())!
        let startOfYesterday = Calendar.current.startOfDay(for: yesterday)
        let startOfToday = Calendar.current.startOfDay(for: Date())
        let endOfYesterday = startOfToday.addingTimeInterval(-1)
        
        statisticsCollection.enumerateStatistics(from: startOfYesterday, to: endOfYesterday) { (statisticsa, stop) in
            let counta = statisticsa.sumQuantity()?.doubleValue(for: .count())
            
            var stepa = Step(count: Int(counta ?? 0), date: statisticsa.startDate)
            stepYesterday.count = stepa.count
        }
    }
    
    func getRemainingStepsPercentage() -> Float {
        return Float(10000 - stepToday.count) / 10000.0
    }
    
    func getRemainingSteps() -> Int {
        if stepToday.count < 10000 {
            return 10000 - stepToday.count
        }
        return 0
    }
}
