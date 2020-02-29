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
