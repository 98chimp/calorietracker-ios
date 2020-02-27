//
//  PersistenceManager.swift
//  CalorieTracker
//
//  Created by Shahin on 2020-02-26.
//  Copyright © 2020 98%Chimp. All rights reserved.
//

import CoreData

class PersistenceManager {
    
    static let shared = PersistenceManager()
    private let entityName = "Food"
    private let containerName = "CalorieTracker"
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "CalorieTracker")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                print("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func saveContext() {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                print("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func delete(food: NSManagedObject) {
        let context = persistentContainer.viewContext
        context.delete(food)
    }
    
    func retrieveAllFoods() -> [NSManagedObject] {
        let emptyFoods = [NSManagedObject]()
        let context = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        do {
            guard let foods = try context.fetch(fetchRequest) as? [NSManagedObject] else { return emptyFoods }
            return foods
        }
        catch {
            let nserror = error as NSError
            print("Unresolved error \(nserror), \(nserror.userInfo)")
            return emptyFoods
        }
    }
}
