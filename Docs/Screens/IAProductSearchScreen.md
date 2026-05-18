# IAProductSearchScreen

Handles searching, filtering, and displaying detailed product information, all in one seamless flow. Allows users to send inquiries to pharmacies about the product.

## Overview
- Module: `IAOverTheCounter`
- Dependencies:
  - pharmacy identifier: from the prerequisites flow.
  - Cart:
    - Displays a cart button for navigating to the checkout flow.
    - Add product to the cart from list or product details.
    - Product availability information.

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
