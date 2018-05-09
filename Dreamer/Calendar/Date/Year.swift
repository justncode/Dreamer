//
//  Year.swift
//  Dreamer
//
//  Created by Justin Rose on 5/9/18.
//  Copyright © 2018 justncode LLC. All rights reserved.
//

struct Year {
    let current: Int
    var months = [Month]()
    
    init(_ current: Int) {
        self.current = current
        months = (0..<12).map { Month(Month.Name(rawValue: $0) ?? .jan, year: current) }
    }
}
