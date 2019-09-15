//
//  Test.swift
//  RotateViewManager
//
//  Created by raxabizze on 2019/9/14.
//  Copyright © 2019 raxabizze. All rights reserved.
//

import SwiftUI

let darkGray = Color(red: 69 / 255, green: 86 / 255, blue: 85 / 255)
let pink = Color(red: 124 / 255, green: 138 / 255, blue: 175 / 255)
let green1 = Color(red: 237 / 255, green: 252 / 255, blue: 194 / 255)
let green2 = Color(red: 161 / 255, green: 216 / 255, blue: 177 / 255)
let green3 = Color(red: 95 / 255, green: 189 / 255, blue: 175 / 255)

struct ExampleParentView: View {
    @State var rotationOn = false
    @State var currentIndex = 0
    
    var body: some View {
        let manager = RotateViewManager(axis: .vertical,
                                        currentIndex: $currentIndex,
                                        rotationOn: $rotationOn,
                                        viewList: [ExampleContentView(rotationOn: $rotationOn, currentIndex: $currentIndex, color: pink),
                                                   ExampleContentView(rotationOn: $rotationOn, currentIndex: $currentIndex, color: green1),
                                                   ExampleContentView(rotationOn: $rotationOn, currentIndex: $currentIndex, color: green2),
                                                   ExampleContentView(rotationOn: $rotationOn, currentIndex: $currentIndex, color: green3),
                                                   ExampleContentView(rotationOn: $rotationOn, currentIndex: $currentIndex, color: pink),
                                                   ExampleContentView(rotationOn: $rotationOn, currentIndex: $currentIndex, color: green1),
                                                   ExampleContentView(rotationOn: $rotationOn, currentIndex: $currentIndex, color: green2),
                                                   ExampleContentView(rotationOn: $rotationOn, currentIndex: $currentIndex, color: green3),
                                                   ExampleContentView(rotationOn: $rotationOn, currentIndex: $currentIndex, color: pink),
                                                   ExampleContentView(rotationOn: $rotationOn, currentIndex: $currentIndex, color: green1),
                                                   ExampleContentView(rotationOn: $rotationOn, currentIndex: $currentIndex, color: green2),
                                                   ExampleContentView(rotationOn: $rotationOn, currentIndex: $currentIndex, color: green3)])
            .background(darkGray)
            .edgesIgnoringSafeArea(.all)
        return manager
    }
}

struct ExampleContentView: View {
    @Binding var rotationOn: Bool
    @Binding var currentIndex: Int
    var color: Color
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Text("toLeft")
                    .frame(width: 100, height: 60)
                    .background(Color.yellow)
                    .cornerRadius(12)
                    .onTapGesture {
                        self.currentIndex -= 1
                }
                Spacer()
                Text("Rotate")
                    .frame(width: 100, height: 60)
                    .background(Color.yellow)
                    .cornerRadius(12)
                    .onTapGesture {
                        self.rotationOn.toggle()
                }
                Spacer()
                Text("toRight")
                    .frame(width: 100, height: 60)
                    .background(Color.yellow)
                    .cornerRadius(12)
                    .onTapGesture {
                        self.currentIndex += 1
                }
                Spacer()
            }
        }
        .background(color)
        .cornerRadius(20)
        
    }
}
