//
//  Month.swift
//  Dreamer
//
//  Created by Justin Rose on 5/9/18.
//  Copyright © 2018 justncode LLC. All rights reserved.
//

import Foundation

struct Month {
    enum Name: Int {
        case jan, feb, mar, apr, may, jun, jul, aug, sep, oct, nov, dec
        
        var description: String {
            switch self {
            case .jan: return "January"
            case .feb: return "February"
            case .mar: return "March"
            case .apr: return "April"
            case .may: return "May"
            case .jun: return "June"
            case .jul: return "July"
            case .aug: return "August"
            case .sep: return "September"
            case .oct: return "October"
            case .nov: return "November"
            case .dec: return "December"
            }
        }
        
        static func of(_ month: Int) -> String {
            return (Name(rawValue: month) ?? .jan).description
        }
    }
    
    var current: Month.Name = .jan
    var year: Int = 2018
    lazy var days = [Int?]()
    
    init(_ current: Month.Name, year: Int) {
        self.current = current
        self.year = year
        days = Array(repeating: nil, count: Date.days(in: current.hashValue, year: year))
    }
}
