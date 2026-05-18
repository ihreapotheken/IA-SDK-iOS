# IAProductSearchScreen

Handles searching, filtering, and displaying detailed product information, all in one seamless flow. Allows users to send inquiries to pharmacies about the product.

## Overview
- Module: `IAOverTheCounter`
- Dependencies:
  - pharmacy identifier: from the prerequisites flow.
  - cart: UI for adding products to cart and navigating to cart screen.

## Signature
```swift
public init() {}
```
    
## Example

`IAProductSearchScreen` inside a SwiftUI TabView.

```swift
import IACore
...
TabView {
    IAProductSearchScreen()
        .tabItem { Text("Search") }
}

```
> [!NOTE]
> Read [Presentation](./../Presentation.md) in order to understand how IA SDK screens can be presented in your app.  
