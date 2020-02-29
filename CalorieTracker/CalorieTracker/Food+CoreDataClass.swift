//
//  Food+CoreDataClass.swift
//  CalorieTracker
//
//  Created by Shahin on 2020-02-27.
//  Copyright © 2020 98%Chimp. All rights reserved.
//
//

import CoreData

@objc(Food)
public class Food: NSManagedObject {
    @NSManaged public var calories: Double
    @NSManaged public var consumptionDates: [Date]
    @NSManaged public var imageData: Data
    @NSManaged public var name: String
}
