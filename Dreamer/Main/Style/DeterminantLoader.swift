//
//  DeterminantLoader.swift
//  Dreamer
//
//  Created by Conner Maddalozzo on 6/7/22.
//  Copyright © 2022 justncode LLC. All rights reserved.
//

import SwiftUI

struct DeterminantLoader: View {
    @State var circleProgress: CGFloat = 0.25
    var body: some View {
        ZStack {
            Circle()
                .stroke(Color("calendarDark"), lineWidth: 15)
                .frame(width: 180*2, height: 200-10*2)
            Circle()
                .trim(from: 0.0, to: circleProgress)
                .stroke(Color("calendarBlue"), lineWidth: 15)
                .frame(width: 200-25*2, height: 200-25*2)
                .rotationEffect(Angle(degrees: -90))
            Text("\(Int(circleProgress*100))%")
                .font(.title2)
        }
    }
}

struct DeterminantLoader_Previews: PreviewProvider {
    static var previews: some View {
        DeterminantLoader()
    }
}
