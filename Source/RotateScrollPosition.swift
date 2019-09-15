//
//  RotateScrollPosition.swift
//  RotateViewManager
//
//  Created by raxabizze on 2019/9/15.
//  Copyright © 2019 raxabizze. All rights reserved.
//

import SwiftUI

struct RotateScrollPosition: View {
    @Binding var rotationOn: Bool
    @Binding var offset: CGFloat
    var axis: Axis.Set
    
    init(rotationOn: Binding<Bool>, offset: Binding<CGFloat>, axis: Axis.Set) {
        self._rotationOn = rotationOn
        self._offset = offset
        self.axis = axis
    }
    
    
    var body: some View {
        GeometryReader { geometry -> Text in
            if self.rotationOn {
                let newOffset = self.axis == .horizontal ? geometry.frame(in: .global).minX :  geometry.frame(in: .global).minY
                if self.offset != newOffset {
                    self.offset = newOffset
                }
            }
            return Text("")
        }.frame(width: 0, height: 0)
    }
}
