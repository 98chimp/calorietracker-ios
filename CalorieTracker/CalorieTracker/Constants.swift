//
//  Constants.swift
//  CalorieTracker
//
//  Created by Shahin on 2020-02-27.
//  Copyright © 2020 98%Chimp. All rights reserved.
//

import Foundation

struct Constant {
    struct Alert {
        struct Title {
            static let attention = "You are about to permanently delete a food from your list"
            
            struct Action {
                static let cancel = "Cancel"
                static let ok = "Okay"
                static let addFoodToToday = "Add Food to Today"
                static let editFood = "Edit Food"
                static let deleteFood = "Delete Food"
                static let delete = "Delete"
                static let fromPhotoLibrary = "From Photo Library"
                static let usingCamera = "Using Camera"
            }
        }
        
        struct Message {
            static let photoSelection = "How would you like to add a photo?"
            static let makeSelection = "Please make your selection."
        }
    }
    
    struct ButtonTitle {
        static let change = "Change"
    }
    
    struct Identifier {
            struct Segue {
            static let toNewFood = "toNewFood"
            static let toFoods = "toFoods"
            static let toToday = "toToday"
        }
        
        struct Cell {
            static let foodCell = "foodCell"
            static let foodCellNib = "FoodTableViewCell"
            static let todayCell = "todayCell"
            static let trendLargeCell = "trendLargeCell"
            static let trendSmallCell = "trendSmallCell"
        }
    }
    
    struct ImageName {
        static let placeholder = "placeholder"
    }
    
    struct Persistence {
        static let contextName = "CalorieTracker"
        static let entityName = "Food"
    }
    
    struct Storyboard {
        static let main = "Main"
        static let foods = "Foods"
        static let today = "Today"
        static let trends = "Trends"
    }
    
    struct ViewController {
        
    }
}
