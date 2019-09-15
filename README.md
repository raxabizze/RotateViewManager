# RotateViewManager

![](https://github.com/raxabizze/RotateViewManager/blob/master/Assets/ExampleGIF1.gif)
![](https://github.com/raxabizze/RotateViewManager/blob/master/Assets/ExampleGIF2.gif)

## Usage
Copy ```Source/RotateViewManager.swift ```

### Example
```swift
struct ExampleParentView: View {
    @State var rotateOn = false
    @State var currentIndex = 0
    
    var body: some View {
    let manager = RotateViewManager(selectedIndex: $currentIndex,
                                        rotationOn: $rotationOn,
                                        viewList: [FirstView(), SecondView(), ThirdView(), ...)          
                                                 .background(Color.yellow)
            .edgesIgnoringSafeArea(.all)
        return manager
    }
}
```

#### Base on 'scrollPosition' to change 'rotationEffect()' 'rotation3DEffect()' and 'scaleEffect()' to make more style.

##### Explain

- `scrollPosition` -> As user scroll, scrollPosition goes between -1 ~ 1.

- `widthOfScrollArea` -> The width of content view.

##### Simple replace the code with below. (RotateViewManager.swift)

- Effect Examples 1 (Like the first gif at top)
```swift
.rotationEffect(.degrees(self.rotationOn ? -Double(50 * scrollPosition) : 0))
.rotation3DEffect(.degrees(self.rotationOn ? 180 : 0), axis: (x: 0, y: scrollPosition, z: 0))
.scaleEffect(self.rotationOn ? 0.6 : 1)
```

- Effect Examples 2 (Like the second gif at top)
```swift
.rotation3DEffect(Angle(degrees: self.rotationOn ? 40 : 0), axis: (x: 1, y: 3, z: 0))
.scaleEffect(self.rotationOn ? 0.8 : 1)
```

## More
- `selectedIndex` -> Indicate current index.
- `rotationOn` -> Turn on/off rotation.
- `viewList` -> Content views.
- `spacing` -> Spacing between each view.
- `blockUserInteractionWhileScrolling` -> Simply block input event while rotation is on.

```swift
init(selectedIndex: Binding<Int>,
         rotationOn: Binding<Bool>,
         viewList: [T],
         spacing: CGFloat = -250,
         blockUserInteractionWhileScrolling: Bool = true) {}
```
