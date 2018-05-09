//
//  Date+Components.swift
//  Dreamer
//
//  Created by Justin Rose on 5/9/18.
//  Copyright © 2018 justncode LLC. All rights reserved.
//

import Foundation

extension Date {
    var day: Int {
        return Calendar.current.component(.day, from: self)
    }
    
    var month: Int {
        return Calendar.current.component(.month, from: self) - 1
    }
    
    var year: Int {
        return Calendar.current.component(.year, from: self)
    }
    
    static func weekday(of date: Date) -> Int {
        return Calendar.current.component(.weekday, from: date) - 1
    }
    
    static func date(from month: Int, year: Int) -> Date {
        return Calendar.current.date(from: DateComponents(year: year, month: month + 1)) ?? Date()
    }
    
    static func days(in month: Int, year: Int) -> Int {
        return (Calendar.current.range(of: .day, in: .month, for: date(from: month, year: year))?.upperBound ?? 0) - 1
    }
}
