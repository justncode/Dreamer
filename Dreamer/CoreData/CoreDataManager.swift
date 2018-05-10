//
//  CoreDataManager.swift
//  Dreamer
//
//  Created by Justin Rose on 5/9/18.
//  Copyright © 2018 justncode LLC. All rights reserved.
//

import CoreData

import CoreData

struct CoreDataManager {
    static let shared = CoreDataManager()
    
    let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "LucidModels")
        container.loadPersistentStores(completionHandler: { (description, error) in
            if let error = error {
                fatalError("Failed loading persistent stores: \(error)")
            }
        })
        return container
    }()
    
    func fetchEntries() -> [Entry] {
        let request = NSFetchRequest<Entry>(entityName: "Entry")
        
        do {
            return try persistentContainer.viewContext.fetch(request)
        } catch let error {
            print("Failed to fetch entries:", error)
            return []
        }
    }
    
    func createTimelessDate(day: Int, month: Int, year: Int) -> TimelessDate {
        let timelessDate = NSEntityDescription.insertNewObject(forEntityName: "TimelessDate", into: persistentContainer.viewContext) as! TimelessDate
        
        timelessDate.setValue(Int16(day), forKey: "day")
        timelessDate.setValue(Int16(month), forKey: "month")
        timelessDate.setValue(Int64(year), forKey: "year")
        
        return timelessDate
    }
    
    func createEntry(title: String, body: String, date: TimelessDate, edited: Date) -> (Entry?) {
        let entry = NSEntityDescription.insertNewObject(forEntityName: "Entry", into: persistentContainer.viewContext) as! Entry
        
        entry.date = date
        entry.setValue(title, forKey: "title")
        entry.setValue(body, forKey: "body")
        entry.setValue(edited, forKey: "edited")
        
        do {
            try persistentContainer.viewContext.save()
            return entry
        } catch let error {
            print("Failed to create entry:", error)
            return nil
        }
    }
    
    func delete(_ entry: Entry, completion: (() -> Void)? = nil) {
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<Entry> = Entry.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "%K == %@ AND %K == %@ AND %K == %@",
                                             argumentArray: ["date.day", entry.date?.day as Any,
                                                             "date.month", entry.date?.month as Any,
                                                             "date.year", entry.date?.year as Any])
        
        do {
            guard let entry = try context.fetch(fetchRequest).first else { return }
            context.delete(entry)
            save()
            completion?()
        } catch let error {
            print("Failed to delete entry:", error)
        }
    }
    
    func deleteAllInstances() {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Entry")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: request)
        
        do {
            try persistentContainer.viewContext.execute(deleteRequest)
        } catch let error {
            print("Error deleting all instances:", error)
        }
    }
    
    func save() {
        do {
            try persistentContainer.viewContext.save()
        } catch let error {
            fatalError("Error saving context: \(error)")
        }
    }
}
