# RotateViewManager

![](https://github.com/raxabizze/RotateViewManager/blob/master/Assets/ExampleGIF1.gif)
![](https://github.com/raxabizze/RotateViewManager/blob/master/Assets/ExampleGIF2.gif)
![](https://github.com/raxabizze/RotateViewManager/blob/master/Assets/ExampleGIF3.gif)
![](https://github.com/raxabizze/RotateViewManager/blob/master/Assets/ExampleGIF4.gif)

## Usage
Copy ```Source/* ```

### Example
```swift
struct ExampleParentView: View {
    @State var rotationOn = false
    @State var currentIndex = 0
    
    var body: some View {
        let manager = RotateViewManager(axis: .horizontal,
                                        currentIndex: $currentIndex,
                                        rotationOn: $rotationOn,
                                        viewList: [FirstView(), SecondView(), ThirdView(), ...])
            .background(darkGray)
            .edgesIgnoringSafeArea(.all)
        return manager
    }
}
```

## More details

### Initializer (RotateViewManager.swift)
- `axis` -> Horizontal or vertical.
- `currentIndex` -> Indicate current index.
- `rotationOn` -> Turn on/off rotation.
- `viewList` -> Content views.
- `spacing` -> Spacing between each view.
- `blockUserInteractionWhileScrolling` -> Simply block input event while rotation is on.

```swift
    init(axis: Axis.Set,
         currentIndex: Binding<Int>,
         rotationOn: Binding<Bool>,
         viewList: [T],
         spacing: CGFloat,
         blockUserInteractionWhileScrolling: Bool = true) {}
```

### Effects (RotateContentView.swift)
##### Base on 'scrollPosition' to change 'rotationEffect()' 'rotation3DEffect()' and 'scaleEffect()' to make more style.

- `scrollPosition` -> As user scroll, scrollPosition goes between -1 ~ 1.

- `scrollArea` -> The width/height of content view.

##### Simply replace the code with below.

- Effect Examples 1 (#1 GIF - horizontal)
```swift
.rotationEffect(.degrees(self.rotationOn ? -Double(50 * scrollPosition) : 0))
.rotation3DEffect(.degrees(self.rotationOn ? 180 : 0), axis: (x: 0, y: scrollPosition, z: 0))
.scaleEffect(self.rotationOn ? 0.6 : 1)
```

- Effect Examples 2 (#2 GIF - horizontal)
```swift
.rotation3DEffect(Angle(degrees: self.rotationOn ? 40 : 0), axis: (x: 1, y: 3, z: 0))
.scaleEffect(self.rotationOn ? 0.8 : 1)
```

- Effect Examples 3 ( #3 GIF - horizontal),  Just remove those three lines.
```swift
//.rotationEffect()
//.rotation3DEffect()
//.scaleEffect()
```

- Effect Examples 4 ( #4 GIF - vertical)
```swift
.rotationEffect(.degrees(self.rotationOn ? -Double(50 * scrollPosition) : 0))
.rotation3DEffect(.degrees(self.rotationOn ? Double(30 * scrollPosition) : 0), axis: (x: 0, y: 1, z: 0))
.scaleEffect(self.rotationOn ? 0.6 : 1)
```
