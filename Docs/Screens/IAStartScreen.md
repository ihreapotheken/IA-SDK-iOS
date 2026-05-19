# IAStartScreen

Acts as the central hub for the IhreApotheken experience, giving users quick access to:
  * Pharmacy details
  * Search and filter products
  * Scan prescriptions
  * Recent orders
  * Cart
  * Product recommendations


## Overview
- Module: `IAIntegrations`
- Dependencies:
  - Pharmacy Identifier: from the prerequisites flow.
  - `IAPharmacy` (Optional): Tapping pharmacy header opens the pharmacy details screen.
  - `IAOverTheCounter`: 
    - Search bar
    - Product grids
  - `IAOrdering` (Optional): 
    - Express delivery section
    - Recent orders section
    - Cart button for navigating to the cart.
  - `IAPrescription` (Optional): Ability to add prescriptions and electronic prescriptions directly from the start screen.
  - `IACardLink` (Optional): Ability to scan physical electronic cards directly from the start screen.
  - `IAIntegrations` (Optional):
    - Appointment booking section

## Signature
```swift
public init()
```

## Example

`IAStartScreen` inside a SwiftUI TabView.

```swift
import IACore
...
TabView {
    IAStartScreen()
        .tabItem { Text("Home") }
}
```
> [!NOTE]
> Read [Presentation](./../Presentation.md) in order to understand how IA SDK screens can be presented in your app.  
