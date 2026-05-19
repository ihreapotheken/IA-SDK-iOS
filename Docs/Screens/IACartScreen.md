# IACartScreen

Provides a complete, self-managed flow for cart, checkout, and payment. The screen is reactive and integrates seamlessly with other modules—when a product is added to the cart elsewhere in the app, the cart screen automatically reflects the update.

**Features**
* **Empty cart screen:** When the cart is empty it shows recommended products and products of the month. It allows users to add products and prescriptions.
* **Cart screen:** Overview of all products and prescriptions in the cart, including cost section.
* **Checkout screen:** Delivery and payment options, product overview, prescription overview, and the cost section.
* **PayPal payment:** In-app PayPal integration.
* **Thank You screen:** Overview of the order, users can provide their own thank you screen (not yet available).

## Overview
- Module: `IAOrdering`
- Dependencies:
  - Pharmacy Identifier: from the prerequisites flow.
  - `IAOverTheCounter` (Optional):
    - Button that opens product search.
    - Tapping product in the cart opens product details.
    - Product grids on empty cart screen.
  - `IAPharmacy` (Optional): 
    - Header opens pharmacy details.
  - `IAPrescription` (Optional): 
    - Allows users to add new prescriptions directly from the cart screen.
  - `IACardLink` (Optional): 
    - Allows users to scan physical electronic cards.

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
}
```

> [!NOTE]
> Read [Presentation](./../Presentation.md) in order to understand how IA SDK screens can be presented in your app.  
