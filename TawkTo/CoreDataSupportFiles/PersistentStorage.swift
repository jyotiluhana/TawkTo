//
//  PersistentStorage.swift
//  TawkTo
//
//  Created by Jyoti Luhana on 16/10/21.
//

import Foundation
import CoreData

class PersistentStorage {
    
    // MARK: - Properties
    static let shared = PersistentStorage()
    lazy var context = persistentContainer.viewContext
    
    private init() {}
    
    
    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "TawkTo")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func fetchManagedObject<T: NSManagedObject>(managedObject: T.Type) -> [T]?
    {
        do {
            guard let result = try PersistentStorage.shared.context.fetch(managedObject.fetchRequest()) as? [T] else {return nil}
            return result
        } catch let error {
            debugPrint(error)
        }

        return nil
    }

}
