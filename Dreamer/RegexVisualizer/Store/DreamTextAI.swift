//
//  DreamTextAI.swift
//  Dreamer
//
//  Created by Conner Maddalozzo on 6/4/22.
//  Copyright © 2022 justncode LLC. All rights reserved.
//

import UIKit

/*
 A common pattern is defined as a substring with the
 minimum length of three that occurs
 at least twice among a group of strings.
 this viewmodel will be used on the basis of 2 different collectionviews i guess
 */
enum TagState: Int {
    case unknown = 0
    case dismissed
    case validated
}

struct JournalTagSchema: Equatable, Hashable {
    var name: String
    var state: TagState = .unknown
    var timesWritten: Int
}

protocol JournalCellDatasource: UICollectionViewCell {
    var ds: JournalTagSchema? {set get}
}
