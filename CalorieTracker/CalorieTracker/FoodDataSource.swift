//
//  FoodDataSource.swift
//  CalorieTracker
//
//  Created by Shahin on 2020-02-28.
//  Copyright © 2020 98%Chimp. All rights reserved.
//

import CoreData

typealias Trend = (date: Date, calories: Double)

final class FoodDataSource {
    
    static var shared = FoodDataSource()
    
    lazy var allFoods: [Food] = {
        return PersistenceManager.shared.retrieveAllFoods().sorted {
            $0.name < $1.name
        }
    }()
    
    lazy var allUconsumedFoods: [Food] = {
        return allFoods.filter({ !$0.isConsumedToday })
    }()
    
    lazy var todayFoods: [Food] = {
        allFoods.filter( {
            if let lastDate = $0.consumptionDates.last {
                return Calendar.current.isDateInToday(lastDate)
            }
            return false
        })
    }()
    
    lazy var totalTodayCalories: Double = {
        return todayFoods.compactMap({ $0.calories }).reduce(.zero, +)
    }()
    
    lazy var sevenDayTrends: [Trend] = {
        var trends = [Trend]()
        let dates = getLast(days: 7)
        dates.forEach({ trends.append(($0, totalCalories(for: $0))) })
        return trends
    }()
    
    lazy var thirtyDayTrends: [Trend] = {
        var trends = [Trend]()
        let dates = getLast(days: 30)
        dates.forEach({ trends.append(($0, totalCalories(for: $0))) })
        return trends
    }()
    
    func totalCalories(for date: Date) -> Double {
        return allFoods(for: date).compactMap({ $0.calories }).reduce(0, +)
    }
    
    func allFoods(for date: Date) -> [Food] {
        var foods = [Food]()
        for food in allFoods {
            guard !food.consumptionDates.isEmpty else { continue }
            for consumptionDate in food.consumptionDates {
                if Calendar.current.isDate(consumptionDate, equalTo: date, toGranularity: .day) {
                    foods.append(food)
                }
            }
        }
        return foods
    }
    
    private func getLast(days numberOfDays: Int) -> [Date] {
        let cal = Calendar.current
        let now = cal.startOfDay(for: Date())
        var days = [Date]()
        
        for i in 0 ..< numberOfDays {
            let pastDate = cal.date(byAdding: .day, value: -i, to: now)!
            days.append(pastDate)
        }
        return days
    }
    
    func createNewFoodItem(name: String, calories: Double, imageData: Data) {
        guard let entity = NSEntityDescription.entity(forEntityName: Constant.Persistence.entityName, in: PersistenceManager.shared.conetext) else { return }
        let food = Food(entity: entity, insertInto: PersistenceManager.shared.conetext)
        food.name = name
        food.calories = calories
        food.imageData = imageData
        food.consumptionDates = []
        PersistenceManager.shared.saveContext()
    }
}
