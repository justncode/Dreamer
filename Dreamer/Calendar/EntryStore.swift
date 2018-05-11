//
//  EntryStore.swift
//  Dreamer
//
//  Created by Justin Rose on 5/10/18.
//  Copyright © 2018 justncode LLC. All rights reserved.
//

import Foundation

class EntryStore {
    var entries = [Entry]()
    var years = [Year]()
    
    init() {
        _ = (0..<100).map { years.append(Year(Date().year-$0)) } /* 100 years */
        entries = CoreDataManager.shared.fetchEntries()
    }
    
    func update(_ entry: Entry, for date: (day: Int, month: Int, year: Int)) {
        years[Date().year-date.year].months[Int(date.month)].days[Int(date.day)] = entry
    }
    
    func delete(_ entry: Entry, for date: (day: Int, month: Int, year: Int)) {
        years[Date().year-date.year].months[Int(date.month)].days[Int(date.day)] = nil
    }
    
    func entry(for date: (day: Int, month: Int, year: Int)) -> Entry? {
        return years[Date().year-date.year].months[Int(date.month)].days[Int(date.day)]
    }
    
    func add(_ entry: Entry, completion: (() -> ())? = nil) {
        guard let date = entry.date else { return }
        
        entries.append(entry)
        update(entry, for: (day: Int(date.day), month: Int(date.month), year: Int(date.year)))
        postNotification()
        completion?()
    }
    
    func update(_ entry: Entry, at index: Int, completion: (() -> Void)? = nil) {
        guard let date = entry.date else { return }
        
        entries[index] = entry
        update(entry, for: (day: Int(date.day), month: Int(date.month), year: Int(date.year)))
        CoreDataManager.shared.save()
        postNotification()
        completion?()
    }
    
    func delete(_ entry: Entry, completion: (() -> Void)? = nil) {
        guard let index = entries.index(of: entry),
            let date = entry.date else { return }
        
        entries.remove(at: index)
        delete(entry, for: (day: Int(date.day), month: Int(date.month), year: Int(date.year)))
        CoreDataManager.shared.delete(entry)
        postNotification()
        completion?()
    }
    
    private func postNotification() {
        NotificationCenter.default.post(name: .entriesUpdated, object: nil)
    }
}
