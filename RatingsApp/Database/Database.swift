//
//  Database.swift
//  RatingsApp
//
//  Created by Kshitij Negi on 18/04/20.
//  Copyright © 2020 Kshitij Negi. All rights reserved.
//

import CoreData
import Foundation

protocol Database {
    func save(rating: Int)
    func savedRatings() -> [Rating]
}

public final class DataBaseHelper {

    enum Constants {
        static let ratingEntityName = "Rating"
    }

    private lazy var persistentContainer: NSPersistentContainer = {

        let container = NSPersistentContainer(name: "CoreDataSample")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    private func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

extension DataBaseHelper: Database {

    func save(rating: Int) {
        let context = persistentContainer.viewContext
        let entity = NSEntityDescription.insertNewObject(forEntityName: Constants.ratingEntityName,
                                                         into: context)
        entity.setValue(rating, forKey: "rating")
        entity.setValue(Date(), forKey:"savedTime")
        do {
            try context.save()
        }
        catch {
            print("Record Can not be Inserted")
        }
    }

    func savedRatings() -> [Rating] {
        let context = persistentContainer.viewContext
        var ratings = [Rating]()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Constants.ratingEntityName)
        fetchRequest.returnsObjectsAsFaults = false
        ratings = try! context.fetch(fetchRequest) as! [Rating]
        return ratings
    }
}
