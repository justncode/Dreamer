//
//  TagSuggestionBrowser.swift
//  Dreamer
//
//  Created by Conner Maddalozzo on 6/5/22.
//  Copyright © 2022 justncode LLC. All rights reserved.
//

import UIKit
import SwiftUI
import CoreData

class TagSuggestionBrowser: UIViewController {
     let container: NSPersistentContainer
     var contentView: TagSuggestionPageView!
   
     override func viewDidLoad() {
         super.viewDidLoad()
         /*TODO utilize determinant loader
          load store of all tags,
          load store of all journals,
          use ML text tagging model to find new tags, and tag journal entries.
          */
         container.loadPersistentStores { [weak self] description, e in
             if let error = e {
                 fatalError("Error: \(error.localizedDescription)")
             }
             else {
                 guard let self = self else {return}
                 var dict = [String: JournalTagSchema]()
                 [
                     JournalTagSchema(name: "Amy", timesWritten: 0),
                     JournalTagSchema(name: "food", state: .validated, timesWritten: 0),
                     JournalTagSchema(name: "eat", state: .validated, timesWritten: 0),
                     JournalTagSchema(name: "superpower", timesWritten: 0),
                     JournalTagSchema(name: "superpower1", timesWritten: 0),
                     JournalTagSchema(name: "superpower2", timesWritten: 0),
                     JournalTagSchema(name: "superpower4", timesWritten: 0)].forEach {
                     dict[$0.name] = $0
                 }
                 self.contentView = TagSuggestionPageView(ds: dict)
                    
                 let contentViewController = UIHostingController(rootView: self.contentView
//                     .environment(\.managedObjectContext, self.container.viewContext).environmentObject(self.deepLink)
                 )
                 self.addChild(contentViewController)
                 self.view.addSubview(contentViewController.view)
                 contentViewController.view.backgroundColor = .clear
                 self.view.backgroundColor = .clear
                 
                 contentViewController.view.translatesAutoresizingMaskIntoConstraints = false
                 contentViewController.view.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
                 contentViewController.view.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
                 contentViewController.view.leftAnchor.constraint(equalTo: self.view.leftAnchor).isActive = true
                 contentViewController.view.rightAnchor.constraint(equalTo: self.view.rightAnchor).isActive = true
             }
         }
         
     }
     
     func refreshCheck() -> Bool {
         let moc = container.viewContext
//         let request: NSFetchRequest<WanderingKitty> = WanderingKitty.fetchRequest()
         return true
//         do{
//             return try moc.fetch(request).isEmpty
//         } catch {
//             return true
//         }
     }
     init() {
         container = NSPersistentContainer(name: "DreamSubstrings")
         super.init(nibName: nil, bundle: nil)
     }
     required init?(coder aDecoder: NSCoder) {
         fatalError("coder not implmented")
     }
    
}

