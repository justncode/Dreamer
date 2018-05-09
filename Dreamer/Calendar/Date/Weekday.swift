//
//  Weekday.swift
//  Dreamer
//
//  Created by Justin Rose on 5/9/18.
//  Copyright © 2018 justncode LLC. All rights reserved.
//

enum Weekday {
    case mon, tue, wed, thu, fri, sat, sun
    
    static func abbreviation(of weekday: Int) -> String {
        switch weekday {
        case 0: return "S"
        case 1: return "M"
        case 2: return "T"
        case 3: return "W"
        case 4: return "T"
        case 5: return "F"
        case 6: return "S"
        default: fatalError("Weekday must be between 0...6")
        }
    }
}
