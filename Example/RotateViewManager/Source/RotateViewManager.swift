//
//  RotateViewManager.swift
//  RotationVerticalView
//
//  Created by raxabizze on 2019/9/13.
//  Copyright © 2019 raxabizze. All rights reserved.
//

import SwiftUI

struct RotateViewManager<T: View>: View {
    @State var offset: CGFloat = 0.0
    @Binding var currentIndex: Int
    @Binding var rotationOn: Bool
    private var axis: Axis.Set
    private var spacing: CGFloat
    private var viewList: [T]
    private var blockUserInteractionWhileScrolling: Bool
    
    init(axis: Axis.Set = .horizontal,
         currentIndex: Binding<Int>,
         rotationOn: Binding<Bool>,
         viewList: [T],
         spacing: CGFloat = -250,
         blockUserInteractionWhileScrolling: Bool = true) {
        self.axis = axis
        self._currentIndex = currentIndex
        self._rotationOn = rotationOn
        self.viewList = viewList
        self.spacing = spacing
        self.blockUserInteractionWhileScrolling = blockUserInteractionWhileScrolling
    }
    
    var body: some View {
        
        //Calculate offset after user tap on a view.
        var newOffset: CGFloat {
            if rotationOn {
                return 0
            } else {
                var index = currentIndex
                index = index >= viewList.count ? viewList.count - 1 : index
                index = index < 0 ? 0 : index
                let size = axis == .horizontal ? UIScreen.main.bounds.width : UIScreen.main.bounds.height
                return -(offset + size * CGFloat(index) )
            }
        }
        
        return ZStack {
            ScrollView(axis, showsIndicators: false) {
                //HStack for .horizontal, VStack for .vertical
                if axis == .horizontal {
                    HStack(spacing: rotationOn ? spacing : 0) {
                        RotateContentView(axis: axis,
                                          offset: $offset,
                                          currentIndex: $currentIndex,
                                          rotationOn: $rotationOn,
                                          viewList: viewList,
                                          spacing: spacing,
                                          blockUserInteractionWhileScrolling: blockUserInteractionWhileScrolling)
                    }
                    .offset(x: newOffset)
                    .animation(.spring())
                } else {
                    VStack(spacing: rotationOn ? spacing : 0) {
                        RotateContentView(axis: axis,
                                          offset: $offset,
                                          currentIndex: $currentIndex,
                                          rotationOn: $rotationOn,
                                          viewList: viewList,
                                          spacing: spacing,
                                          blockUserInteractionWhileScrolling: blockUserInteractionWhileScrolling)
                    }
                    .offset(y: newOffset)
                    .animation(.spring())
                }
            }
        }
        .edgesIgnoringSafeArea([.top, .bottom])
        .animation(.interpolatingSpring(stiffness: 150, damping: 30))
    }
}

