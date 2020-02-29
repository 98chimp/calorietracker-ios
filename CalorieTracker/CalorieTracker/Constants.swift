//
//  Constants.swift
//  CalorieTracker
//
//  Created by Shahin on 2020-02-27.
//  Copyright © 2020 98%Chimp. All rights reserved.
//

import Foundation

struct Constants {
    struct Alerts {
        struct Titles {
            static let attention = "You are about to permanently delete a food from your list"
            struct Actions {
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
        
        struct Messages {
            static let photoSelection = "How would you like to add a photo?"
            static let makeSelection = "Please make your selection."
        }
    }
    
    struct ButtonTitles {
        static let change = "Change"
    }
    
    struct Identifiers {
        struct Segues {
            static let toNewFood = "toNewFood"
        }
        
        struct Cells {
            static let foodCell = "foodCell"
            static let todayCell = "todayCell"
            static let trendLargeCell = "trendLargeCell"
            static let trendSmallCell = "trendSmallCell"
        }
    }
    
    struct ImageNames {
        static let placeholder = "placeholder"
    }
    
    struct Persistence {
        static let contextName = "CalorieTracker"
        static let entityName = "Food"
    }
}
