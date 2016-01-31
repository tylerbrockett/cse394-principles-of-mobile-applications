//
//  StatsHelper.swift
//  hw-1
//
//  Created by Tyler Brockett on 1/28/16.
//  Copyright © 2016 Tyler Brockett. All rights reserved.
//

import Foundation

class StatsHelper {
    
    var weeklyStats: [DailyStats] = []
    
    init(){
        
    }
    
    func addDailyStats(day: DailyStats){
        weeklyStats.insert(day, atIndex: 0)
        if weeklyStats.count > 7{
            weeklyStats.removeLast()
        }
        NSLog("Weekly Count Items: \(weeklyStats.count)")
    }
    
    func getWeeklyCaloricIntake() -> Int {
        var result: Int = 0
        for day in weeklyStats {
            result += day.cFood
        }
        return result
    }
    
    func getWeeklyCaloriesBurned() -> Int {
        var result: Int = 0
        for day in weeklyStats {
            result += (day.cRun + day.cStrength)
        }
        return result
    }
    
    func getWeeklyAverageBloodPressure() -> Int {
        if weeklyStats.count == 0{
            return 0
        }
        var runningTotal: Int = 0
        for day in weeklyStats {
            runningTotal = runningTotal + day.bloodPressure
        }
        return (runningTotal / weeklyStats.count)
    }
    
    func getWeeklyWeightChange() -> Int {
        var newestWeight: Int = 0
        var oldestWeight: Int = 0
        
        if weeklyStats.count > 0{
            newestWeight = weeklyStats[0].weight
            oldestWeight = weeklyStats[weeklyStats.count - 1].weight
        }
        return (newestWeight - oldestWeight)
    }
}


class DailyStats {
    
    var tRun: Int = -Int.max
    var cRun: Int = -Int.max
    var tStrength: Int = -Int.max
    var cStrength: Int = -Int.max
    var cFood: Int = -Int.max
    var weight: Int = -Int.max
    var bloodPressure: Int = -Int.max
    
    init(tRun: Int, cRun: Int, tStrength: Int, cStrength: Int, cFood: Int, weight: Int, bloodPressure: Int){
        self.tRun = tRun
        self.cRun = cRun
        self.tStrength = tStrength
        self.cStrength = cStrength
        self.cFood = cFood
        self.weight = weight
        self.bloodPressure = bloodPressure
    }
    
    func hasErrors() -> Bool {
        var result: Bool = false
        result = result || (self.tRun == -Int.max)
        result = result || (self.cRun == -Int.max)
        result = result || (self.tStrength == -Int.max)
        result = result || (self.cStrength == -Int.max)
        result = result || (self.cFood == -Int.max)
        result = result || (self.weight == -Int.max)
        result = result || (self.bloodPressure == -Int.max)
        return result
    }
}