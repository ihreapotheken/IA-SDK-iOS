# IAProductSearchScreen

This screen serves as a starting point for product search. It offers following features:
* **Search screen**: Search bar with list of products, allows filtering and sorting.
* **Product details**: Displays details of a selected product.
* **Product inquiry**: Enables the user to send an email to pharmacies and inquire about the product.
* **Cart integration**: The cart is integrated into the list and details if the `IAOrdering` module is set up.
* **Product scanner**: Users can simply scan the product instead of searching it.

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
