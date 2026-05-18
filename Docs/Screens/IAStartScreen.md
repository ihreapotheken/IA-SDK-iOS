# IAStartScreen

Acts as the central hub for the IhreApotheken experience, giving users quick access to key features like product search, prescription scanning, and cart management.

## Overview
- Module: `IAIntegrations`
- Dependencies:
  - pharmacy identifier: from the prerequisites flow.
  - Cart: displays a cart button for navigating to the checkout flow.

## Signature
```swift
public init()
```

## Example

`IAStartScreen` inside a SwiftUI TabView.

```swift
import IAIntegrations
...
TabView {
    IAStartScreen()
        .tabItem { Text("Home") }
}
```
> [!NOTE]
> Read [Presentation](./../Presentation.md) in order to understand how IA SDK screens can be presented in your app.  
