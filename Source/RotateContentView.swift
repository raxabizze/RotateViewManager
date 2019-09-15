//
//  RotateContentView.swift
//  RotateViewManager
//
//  Created by raxabizze on 2019/9/15.
//  Copyright © 2019 raxabizze. All rights reserved.
//

import SwiftUI

struct RotateContentView<T: View>: View {
    @Binding var offset: CGFloat
    @Binding var rotationOn: Bool
    @Binding var currentIndex: Int
    private var axis: Axis.Set
    private var viewList: [T]
    private var spacing: CGFloat
    private var blockUserInteractionWhileScrolling: Bool
    
    init(axis: Axis.Set,
         offset: Binding<CGFloat>,
         currentIndex: Binding<Int>,
         rotationOn: Binding<Bool>,
         viewList: [T],
         spacing: CGFloat,
         blockUserInteractionWhileScrolling: Bool = true) {
        self.axis = axis
        self._offset = offset
        self._currentIndex = currentIndex
        self._rotationOn = rotationOn
        self.viewList = viewList
        self.spacing = spacing
        self.blockUserInteractionWhileScrolling = blockUserInteractionWhileScrolling
    }
    
    var body: some View {
        
        //Calculate content view width or height
        var scrollArea: CGFloat {
            let count = CGFloat(viewList.count - 1) == 0 ? 1 : CGFloat(viewList.count - 1)
            if axis == .horizontal {
                return count * (UIScreen.main.bounds.width + spacing)
            } else {
                return count * (UIScreen.main.bounds.height + spacing)
            }
        }
        
        //Range: -1 ~ 1 (care for situation like only one view, scrollArea will be 0)
        let scrollPosition: CGFloat = -offset / ((scrollArea == 0 ? 1 : scrollArea) / 2) - 1
        
        return Group {
            //Get scroll position
            RotateScrollPosition(rotationOn: $rotationOn, offset: $offset, axis: self.axis)
            
            //Leading padding for fist view.
            if axis == .horizontal {
                Spacer().frame(width: self.rotationOn ? -self.spacing * 2 : 0)
            } else {
                Spacer().frame(height: self.rotationOn ? -self.spacing * 2 : 0)
            }
            
            
            ForEach(0..<self.viewList.count) { index in
                ZStack {
                    //View
                    self.viewList[index]
                        //block scroll event in normal mode.
                        .gesture(DragGesture())
                    
                    //Block user input in rotation mode.
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
                    // MARK: - Base on 'scrollPosition' to change 'rotationEffect()' 'rotation3DEffect()' and 'scaleEffect()' to make more style.
                    .rotationEffect(.degrees(self.rotationOn ? -Double(50 * scrollPosition) : 0))
                    .rotation3DEffect(.degrees(self.rotationOn ? Double(30 * scrollPosition) : 0), axis: (x: 0, y: 1, z: 0))
                    .scaleEffect(self.rotationOn ? 0.6 : 1)
                    .animation(.interpolatingSpring(stiffness: 150, damping: 30))
                    .frame(width: self.axis == .horizontal ? UIScreen.main.bounds.width : nil,
                           height: self.axis == .horizontal ? nil : UIScreen.main.bounds.height)
                    .onTapGesture {
                        self.currentIndex = index
                        self.rotationOn = false
                }
            }
        }
    }
}
