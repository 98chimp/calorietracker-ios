//
//  FoodDataSource.swift
//  CalorieTracker
//
//  Created by Shahin on 2020-02-28.
//  Copyright © 2020 98%Chimp. All rights reserved.
//

import CoreData

final class FoodDataSource {
    
    static var shared = FoodDataSource()
    
    var allFoods: [Food] {
        return PersistenceManager.shared.retrieveAllFoods().sorted {
            $0.name < $1.name
        }
    }
    
    var allUconsumedFoods: [Food] {
        return allFoods.filter({ !$0.isConsumedToday })
    }
    
    var todayFoods: [Food] {
        allFoods.filter( {
            if let lastDate = $0.consumptionDates.last {
                return Calendar.current.isDateInToday(lastDate)
            }
            return false
        })
    }
    
    var totalTodayCalories: Double {
        return todayFoods.compactMap({ $0.calories }).reduce(.zero, +)
    }
    
    func createNewFoodItem(name: String, calories: Double, imageData: Data) {
        guard let entity = NSEntityDescription.entity(forEntityName: Constants.Persistence.entityName, in: PersistenceManager.shared.conetext) else { return }
        let food = Food(entity: entity, insertInto: PersistenceManager.shared.conetext)
        food.name = name
        food.calories = calories
        food.imageData = imageData
        food.consumptionDates = []
        PersistenceManager.shared.saveContext()
    }
}
