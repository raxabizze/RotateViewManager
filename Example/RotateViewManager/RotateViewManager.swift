//
//  ContentView.swift
//  RotateViewManager
//
//  Created by raxabizze on 2019/9/13.
//  Copyright © 2019 raxabizze. All rights reserved.
//

import SwiftUI

struct RotateViewManager<T: View>: View {
    @State var offset: CGFloat = 0.0
    @Binding var selectedIndex: Int
    @Binding var rotationOn: Bool
    private var spacing: CGFloat
    private var viewList: [T]
    private var blockUserInteractionWhileScrolling: Bool
    
    init(selectedIndex: Binding<Int>,
         rotationOn: Binding<Bool>,
         viewList: [T],
         spacing: CGFloat = -250,
         blockUserInteractionWhileScrolling: Bool = true) {
        self._selectedIndex = selectedIndex
        self._rotationOn = rotationOn
        self.viewList = viewList
        self.spacing = spacing
        self.blockUserInteractionWhileScrolling = blockUserInteractionWhileScrolling
    }
    
    var body: some View {
        
        var newOffset: CGFloat {
            if rotationOn {
                return 0
            } else {
                var index = selectedIndex
                index = index >= viewList.count ? viewList.count - 1 : index
                index = index < 0 ? 0 : index
                return -(offset + UIScreen.main.bounds.width * CGFloat(index) )
            }
        }
        
        //Content view width
        let widthOfScrollArea: CGFloat = CGFloat(viewList.count) * (UIScreen.main.bounds.width + spacing) - spacing - 414
        //Range: -1 ~ 1 (care for situation like only one view, widthOfScrollArea will be 0)
        let scrollPosition: CGFloat = -offset / ((widthOfScrollArea == 0 ? 1 : widthOfScrollArea) / 2) - 1
        
        return ZStack {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: self.rotationOn ? self.spacing : 0) {
                    GeometryReader { geometry -> Text in
                        if self.rotationOn {
                            //ScrollView position
                            let newOffset = geometry.frame(in: .global).minX
                            if self.offset != newOffset {
                                self.offset = newOffset
                            }
                        }
                        return Text("")
                    }.frame(width: 0, height: 0)
                    
                    Spacer().frame(width: self.rotationOn ? -self.spacing * 2 : 0)
                    
                    ForEach(0..<self.viewList.count) { index in
                        ZStack {
                            self.viewList[index]
                                .gesture(DragGesture())
                            
                            if self.rotationOn && self.blockUserInteractionWhileScrolling {
                                VStack {
                                    HStack {
                                        Spacer()
                                    }
                                    Spacer()
                                }.background(Color.black.opacity(0.01))
                                    .disabled(true)
                            }
                        }
                            //Base on 'scrollPosition' to change 'rotationEffect()' 'rotation3DEffect()' and 'scaleEffect()' to make more style.
                            .rotationEffect(.degrees(self.rotationOn ? -Double(50 * scrollPosition) : 0))
                            .rotation3DEffect(.degrees(self.rotationOn ? 180 : 0), axis: (x: 0, y: scrollPosition, z: 0))
                            .scaleEffect(self.rotationOn ? 0.6 : 1)
                            .animation(.interpolatingSpring(stiffness: 150, damping: 30))
                            .frame(width: UIScreen.main.bounds.width)
                            .onTapGesture {
                                self.selectedIndex = index
                                self.rotationOn = false
                        }
                    }
                }
                .offset(x: newOffset)
            }
            .edgesIgnoringSafeArea([.top, .bottom])            
        }
        .edgesIgnoringSafeArea([.top, .bottom])
        .animation(.interpolatingSpring(stiffness: 150, damping: 30))
    }
}
