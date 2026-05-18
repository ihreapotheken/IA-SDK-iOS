# IACartScreen

Provides a complete, self-managed flow for cart, checkout, and payment. The screen is reactive and integrates seamlessly with other modules—when a product is added to the cart elsewhere in the app, the cart screen automatically reflects the update.

## Overview
- Module: `IAOrdering`
- Dependencies:
  - Pharmacy Identifier: from the prerequisites flow.
  - `IAOverTheCounter` (Optional):
    - Button that opens product search.
    - Users can open product details by tapping on the product in the cart.
  - `IAPharmacy` (Optional): Header opens pharmacy details.
  - `IAPrescription` (Optional): Button that allows user to add new prescriptions.

## Signature
```swift
public init()
```

## Example
`IACartScreen` inside a SwiftUI TabView.

```swift
import IACore
...
TabView {
    IACartScreen()
        .tabItem { Text("Cart") }
```

> [!NOTE]
> Read [Presentation](./../Presentation.md) in order to understand how IA SDK screens can be presented in your app.  
