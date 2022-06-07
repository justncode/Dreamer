//
//  TagSuggestionPageView.swift
//  Dreamer
//
//  Created by Conner Maddalozzo on 6/6/22.
//  Copyright © 2022 justncode LLC. All rights reserved.
//

import SwiftUI

struct TagSuggestionPageView: View {
    @State var ds: [String: JournalTagSchema]
    var columns: [GridItem] =
    Array(repeating: .init(.flexible()), count:2)
    
    func getFreshList() -> [JournalTagSchema] {
        let keys = ds.keys.shuffled()
        return keys.filter { key in
            guard let tag = ds[key] else {return false}
            return tag.state == .unknown
        }.map {
            return ds[$0]!
        }
    }
    func getValidatedList() -> [JournalTagSchema] {
        let keys = ds.keys.sorted { $0 < $1 }
        return keys.filter { key in
            guard let tag = ds[key] else {return false}
            return tag.state == .validated
        }.map {
            // we just proved it exists up above
            return ds[$0]!
        }
    }
    var body: some View {
         ScrollView {
             HStack {
                 Text("/*TODO: Implment text tag ML model*/")
                     .padding(.leading,10).foregroundColor(.white)
                 Spacer()
             }
            LazyVGrid(columns: columns,spacing: 10) {
                 ForEach(getFreshList(), id: \.self) { tag in
                     HStack(spacing: 0){
                         Button("🆇") {
                             ds[tag.name]?.state = .dismissed
                         }.font(.headline)
                        .frame(width: 25, height: 25, alignment: .center)
                         .foregroundColor(.purple)
                         Text(tag.name)
                             .font(Font.system(size: 14, weight: Font.Weight.medium, design: Font.Design.monospaced))
                             .foregroundColor(.white)
                             .frame(width: 100)
                         Button("☑️") {
                             ds[tag.name]?.state = .validated
                         }
                         .font(.headline)
                        .frame(width: 30, height: 30, alignment: .center)
                         .foregroundColor(.white)
                         
                     }
                     .overlay(
                        RoundedRectangle(cornerRadius: 5, style: .circular)
                            .stroke(lineWidth: 2)
                            .foregroundColor(.white))
                 }
             }.font(.largeTitle)
             
             
         }.background(Color.clear)
    }
}

struct TagSuggestionPageView_Previews: PreviewProvider {
    var ds: [String: JournalTagSchema] = {
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
        return dict
        
    }()
    static var previews: some View {
        TagSuggestionPageView(ds: TagSuggestionPageView_Previews().ds)
    }
}
