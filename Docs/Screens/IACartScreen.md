# IACartScreen

Provides a complete, self-managed flow for cart, checkout, and payment. The screen is reactive and integrates seamlessly with other modules—when a product is added to the cart elsewhere in the app, the cart screen automatically reflects the update.

## Overview
- Module: `IAOrdering`
- Dependencies:
  - pharmacy identifier: from the prerequisites flow.

## Signature
```swift
public init()
```

> [!NOTE]
> Read [Presentation](./../Presentation.md) in order to understand how IA SDK screens can be presented in your app.  

## Example
`IACartScreen` inside a SwiftUI TabView.

```swift
import IACore
...
TabView {
    IACartScreen()
        .tabItem { Text("Cart") }
```
