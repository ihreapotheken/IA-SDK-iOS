# IAProductSearchScreen

Handles searching, filtering, and displaying detailed product information, all in one seamless flow. Allows users to send inquiries to pharmacies about the product.

## Overview
- Module: `IAOverTheCounter`
- Dependencies:
  - Pharmacy Identifier: from the prerequisites flow.
  - `IAOrdering`:
    - Cart button for navigating to the cart.
    - Adds products to the cart from list or product details.
    - Product availability information.
  - `IAPrescription`:
    - Product scanner.

## Signature
```swift
public init()
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
